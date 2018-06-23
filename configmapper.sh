#! /usr/bin/env zsh

function executable() { which $1 >> /dev/null && [[ -x `which $1` ]] }
function is_bsd() { [[ `uname` = 'Darwin' || `uname` = 'FreeBSD' ]] }

function link() {
  src=$1; des=$2
  if [[ -e "$src" ]]; then
    if is_bsd; then
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
    gitdl https://github.com/VundleVim/Vundle.vim.git "$(extern vim/bundle/Vundle.vim)"
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
fi

# Ensure certain directories are not made into links
for dir in ".vnc" ".stack" ".gnupg"; do
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
  SRCPATH1="$BASE/dist-newstyle/build/x86_64-$OS/ghc-$GHC_VER/$PKG/build/$EXEC/$EXEC"
  SRCPATH2="$BASE/dist-newstyle/build/x86_64-$OS/ghc-$GHC_VER/$PKG/x/$EXEC/build/$EXEC/$EXEC"
  if [[ -e "$SRCPATH1" ]]; then
    link "$SRCPATH1" $HOME/.local/bin/$TGT
  elif [[ -e "$SRCPATH2" ]]; then
    link "$SRCPATH2" $HOME/.local/bin/$TGT
  else
    echo "\x1b[31m$SRCPATH2 does not exist\x1b[0m"
  fi
}
function hask_build () {
  PKG=$1
  EXEC=$2
  FLAGS=$3
  pushd $(extern hs)
  [[ -d "$PKG" ]] || cabal get "$PKG"
  pushd "$PKG"
  cabal new-build --flags="$FLAGS"
  echo $PWD
  hask_link "$PWD" "$PKG" "$EXEC"
  popd
  popd
}
if which cabal >> /dev/null ;
then
  hask_build hledger-1.5      hledger
  hask_build pandoc-2.1.3     pandoc
  hask_build hlint-2.1.3      hlint
  hask_build hpack-0.28.2     hpack
  # hask_build packunused-0.1.2 packunused
  hask_build threadscope-0.2.11 threadscope

  if [[ "$(uname)" != "Darwin" ]]; then
    hask_build xmobar-0.26      xmobar "with_xft with_alsa"
    pushd "$PWD/dot/xmonad"
    cabal new-build
    hask_link $PWD xmonconf-0.1.0.0 xmonconf xmonad
    popd
  fi
fi

[[ ! -d "${XDG_CONFIG_HOME=$HOME/.config}" ]] && mkdir -p "$XDG_CONFIG_HOME"
for p in $PWD/xdg/*; do
  link "$p" "$XDG_CONFIG_HOME/$(basename $p)"
done

link "$(extern vim/bundle)" "$PWD/dot/vim/bundle"

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
    caine)
      sys_install 644 etc/systemd/system/netctl-auto-resume@.service
      sys_install 644 etc/X11/xorg.conf.d/20-intel.conf
      sys_install 644 etc/X11/xorg.conf.d/50-libinput.conf
      sys_install 644 etc/docker/daemon.json
      ;;
  esac
fi
