#! /usr/bin/env zsh

function executable() { command -v $1 >> /dev/null && [[ -x `command -v $1` ]] }
function is_macos() { [[ `uname` = 'Darwin' ]] }
function is_bsd() { [[ `uname` = 'FreeBSD' ]] }
function is_linux() { [[ `uname` = 'Linux' ]] }

function link() {
  src=$1; des=$2
  if [[ -e "$src" ]]; then
    if is_bsd || is_macos; then
      ln -sfhF "$src" "$des"
    else
      ln -sfT "$src" "$des"
    fi
  else
    [[ -h "$des" ]] && rm "$des"
  fi
}

function gitdl() {
  src=$1; des=$2
  if [[ -d $des ]]; then
    pushd "$des"
    git pull origin master
    popd
  else
    git clone "$src" "$des"
  fi
}
function extern() { echo "$HOME/thirdparty/$1" }

UPDATE_EXTERNAL=false
SYSTEM=false

while [[ $# -gt 0 ]]; do
  case $1 in
    '-update-external') UPDATE_EXTERNAL=true ;;
    '-system') SYSTEM=true ;;
    *) echo "Unknown option '$1'"; exit ;;
  esac
  shift
done

if $UPDATE_EXTERNAL; then
  mkdir -p "$(extern vim)" "$(extern style)"
  if executable git; then
    gitdl https://github.com/junegunn/vim-plug.git "$(extern vim/bundle/vim-plug)"
    gitdl https://github.com/robbyrussell/oh-my-zsh.git "$(extern zsh/oh-my-zsh)"
    gitdl https://github.com/zsh-users/zsh-completions.git "$(extern zsh/zsh-completions)"
    gitdl https://github.com/solarized/xresources.git "$(extern style/solarized-xresources)"
    if is_bsd; then
      #gitdl http://github.com/chriskempson/base16-iterm2.git "$HOME/thirdparty/style/base16-iterm2"
      #curl -G --create-dirs -o "$(extern style/solarized-iterm2/#1)" 'https://raw.githubusercontent.com/altercation/solarized/master/iterm2-colors-solarized/{Solarized%20Dark.itermcolors}'
    fi
    #gitdl http://github.com/chriskempson/base16-xresources.git "$HOME/thirdparty/style/base16-xresources"
    #gitdl http://github.com/creationix/nvm.git "$(extern js/nvm)"
  fi

  if is_linux && ! executable ghcup; then
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
  fi
fi

# Ensure certain directories are not made into links
for dir in ".vnc" ".gnupg"; do
  [[ ! -d "$HOME/$dir" ]] && mkdir "$HOME/$dir"
done

for f in dot/*; do
  tgt="$HOME/.$(basename $f)"
  if [[ -d "$tgt" && ! -L "$tgt" ]]; then
    for f2 in $f/*; do
      link "$PWD/$f2" "$tgt/$(basename $f2)";
    done
  else
    link "$PWD/$f" "$tgt"
  fi
done
[[ ! -d "$HOME/.cache/mutt" ]] && mkdir -p "$HOME/.cache/mutt"

LOCAL="$HOME/.local"
[[ ! -d "$LOCAL/bin" ]] && mkdir -p "$LOCAL/bin"
for b in bin/*; do
  link "$PWD/$b" "$LOCAL/$b"
done

if is_macos && ls mac/*.plist &> /dev/null; then
  for pl in mac/*.plist; do
    link "$PWD/$pl" "$HOME/Library/LaunchAgents/$(basename $pl)"
  done
fi

function hask_link () {
  BASE=$1
  PKG=$2
  EXEC=$3
  TGT=${4-$3}

  GHC_VER=$(ghc --numeric-version)
  case $(uname) in
    Darwin) OS=osx ;;
    FreeBSD) OS=freebsd ;;
    Linux | * ) OS=linux ;;
  esac
  case $(uname -m) in
    arm64) ARCH=aarch64 ;;
    *) ARCH=$(uname -m) ;;
  esac
  SRCPATH1="$BASE/dist-newstyle/build/$ARCH-$OS/ghc-$GHC_VER/$PKG/build/$EXEC/$EXEC"
  SRCPATH2="$BASE/dist-newstyle/build/$ARCH-$OS/ghc-$GHC_VER/$PKG/x/$EXEC/build/$EXEC/$EXEC"
  if [[ -e "$SRCPATH1" ]]; then
    link "$SRCPATH1" $HOME/.local/bin/$TGT
  elif [[ -e "$SRCPATH2" ]]; then
    link "$SRCPATH2" $HOME/.local/bin/$TGT
  else
    echo "\x1b[31m$SRCPATH2 does not exist\x1b[0m"
  fi
}
function hask_build () {
  PKG=$1; shift
  EXEC=$1; shift
  pushd $(extern hs)
  [[ -d "$PKG" ]] || cabal get "$PKG"
  pushd "$PKG"
  cabal build "$@"
  echo $PWD
  hask_link "$PWD" "$PKG" "$EXEC"
  popd
  popd
}
if executable cabal; then
  mkdir -p $(extern hs)
  # Not Mac and not WSL
  if [[ "$(uname)" != "Darwin" ]] && ! [[ -v WSLENV ]]; then
    hask_build xmobar-0.46 xmobar --flags="with_xft -with_alsa"
    pushd "$PWD/dot/xmonad"
    cabal build
    hask_link $PWD xmonconf-0.1.0.0 xmonconf xmonad-$(uname -m)-$(uname -s | tr 'A-Z' 'a-z')
    popd
  fi

  hask_build hledger-1.32.2   hledger
  hask_build pandoc-cli-3.1.11.1    pandoc
  hask_build hlint-3.6.1      hlint
  # hask_build threadscope-0.2.14.1 threadscope
  # hask_build darcs-2.16.5 darcs --allow-newer
fi

[[ ! -d "${XDG_CONFIG_HOME=$HOME/.config}" ]] && mkdir -p "$XDG_CONFIG_HOME"
for p in $PWD/xdg/*; do
  if [[ $(basename $p) == "msmtp" ]]; then
    local XDGCFG="$XDG_CONFIG_HOME/$(basename $p)"
    rm -r "$XDGCFG"
    cp -R "$p" "$XDGCFG"
  else
    link "$p" "$XDG_CONFIG_HOME/$(basename $p)"
  fi
done

link "$(extern vim/bundle)" "$PWD/dot/vim/bundle"

if [[ -v WSLENV ]]; then
  SSHPAGEANT=$HOME/.local/bin/wsl2-ssh-pageant.exe
  if ! [[ -e "$SSHPAGEANT" ]]; then
    curl -L https://github.com/BlackReloaded/wsl2-ssh-pageant/releases/download/v1.2.0/wsl2-ssh-pageant.exe -o "$SSHPAGEANT"
    chmod 775 "$SSHPAGEANT"
  fi
fi

# link "$HOME/.Xresources" "$HOME/.Xresources-x2go"
# link "$HOME/.xsession" "$HOME/.xsession-x2go"
# link "$HOME/.xsessionrc" "$HOME/.xsessionrc-x2go"

function sys_install () {
  is_bsd && PREFIX=/usr/local
  MODE=$1
  ETC=$PREFIX/$2
  USR=$2

  echo "copying system file $USR -> $ETC"
  sudo install -o root -g wheel -m $MODE $USR $ETC
}

if $SYSTEM; then
  for s in etc/sudoers.d/*; do
    sys_install 644 $s
  done
  sys_install 644 etc/hosts

  case $HOST in
    kangding)
      sys_install 644 etc/systemd/system/cronie.service
      sys_install 644 etc/rsyncd.conf
      sys_install 644 etc/docker/daemon.json
      ;;
    wanhangdu)
      sys_install 644 etc/systemd/system/nfs-data.mount
      sys_install 644 etc/systemd/system/nfs-homes.mount
      sys_install 644 etc/systemd/system/nfs-media.mount
      sys_install 644 etc/X11/xorg.conf.d/20-intel.conf
      sys_install 644 etc/X11/xorg.conf.d/50-libinput.conf
      sys_install 644 etc/docker/daemon.json
      ;;
  esac
fi
