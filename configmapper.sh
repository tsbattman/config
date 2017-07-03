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
    gitdl http://github.com/VundleVim/Vundle.vim.git "$(extern vim/bundle/Vundle.vim)"
    gitdl http://github.com/robbyrussell/oh-my-zsh.git "$(extern zsh/oh-my-zsh)"
    gitdl http://github.com/zsh-users/zsh-completions.git "$(extern zsh/zsh-completions)"
    gitdl http://github.com/solarized/xresources.git "$(extern style/solarized-xresources)"
    if is_bsd; then
      #gitdl http://github.com/chriskempson/base16-iterm2.git "$HOME/thirdparty/style/base16-iterm2"
      #curl -G --create-dirs -o "$(extern style/solarized-iterm2/#1)" 'https://raw.githubusercontent.com/altercation/solarized/master/iterm2-colors-solarized/{Solarized%20Dark.itermcolors}'
    fi
    #gitdl http://github.com/chriskempson/base16-xresources.git "$HOME/thirdparty/style/base16-xresources"
    #gitdl http://github.com/creationix/nvm.git "$(extern js/nvm)"
  fi
fi

# Ensure certain directories are not made into links
[[ ! -d "$HOME/.vnc" ]] && mkdir "$HOME/.vnc"
[[ ! -d "$HOME/.stack" ]] && mkdir "$HOME/.stack"

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

LOCAL="$HOME/.local"
[[ ! -d "$LOCAL/bin" ]] && mkdir -p "$LOCAL/bin"
for b in bin/*; do
  link "$PWD/$b" "$LOCAL/$b"
done

# XXX: Prefer stack install to cabal sandbox installs
# stack install hlint hoogle pandoc packdeps
# stack install xmonad xmobar --flag xmobar:with_xft --flag xmobar:with_iwlib
# function hask_link () {
#   dir="$(extern haskell/$1/.cabal-sandbox/bin)"; shift
#   for f in "$@"; do
#     link "$dir/$f" "$HOME/bin/$f"
#   done
# }
pushd "$PWD/dot/xmonad"
cabal new-build
cp ./dist-newstyle/build/xmonconf-0.1.0.0/build/xmonconf/xmonconf $HOME/.local/bin/xmonad
popd

# hask_link hlint hlint
# hask_link hoogle hoogle
# hask_link pandoc pandoc
# hask_link xmonad xmonad
# hask_link xmobar xmobar

[[ ! -d "${XDG_CONFIG_HOME=$HOME/.config}" ]] && mkdir -p "$XDG_CONFIG_HOME"
for p in $PWD/xdg/*; do
  link "$p" "$XDG_CONFIG_HOME/$(basename $p)"
done

link "$(extern vim/bundle)" "$PWD/dot/vim/bundle"

# link "$HOME/.Xresources" "$HOME/.Xresources-x2go"
# link "$HOME/.xsession" "$HOME/.xsession-x2go"
# link "$HOME/.xsessionrc" "$HOME/.xsessionrc-x2go"

function etc_copy () {
  ETC=/etc/$1
  if [[ $# -lt 2 ]]; then
    USR=etc/$1
  else
    USR=$2
  fi
  echo "copying system file $USR -> $ETC"
  sudo cp $USR $ETC
}

if $SYSTEM; then
  for s in etc/sudoers.d/*; do
    etc_copy ${s#etc/}
  done
  etc_copy hosts

  case $HOST in
    kangding)
      etc_copy systemd/system/cronie.service
      etc_copy rsyncd.conf
      ;;
    caine)
      etc_copy systemd/system/netctl-auto-resume@.service
      ;;
  esac
  # etc_copy msmtprc

  # openssl enc -des3 -in etc/aliases.enc -out etc/aliases -d
  # etc_copy aliases
  # rm etc/aliases
fi
