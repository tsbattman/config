#! /usr/bin/env zsh

function executable() { which $1 >> /dev/null && [[ -x `which $1` ]] }
function is_bsd() { [[ `uname` = 'Darwin' ]] }

if is_bsd; then function link() { src=$1; des=$2; ln -sfhF "$src" "$des" }
else function link() { src=$1; des=$2; ln -sfT "$src" "$des" } fi
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

while [[ $# -gt 0 ]]; do
  case $1 in
    '-update-external') UPDATE_EXTERNAL=true ;;
    *) echo "Unknown option '$1'"; exit ;;
  esac
  shift
done

if $UPDATE_EXTERNAL; then
  mkdir -p "$(extern vim)" "$(extern style)"
  if executable git; then
    gitdl http://github.com/Shougo/neobundle.vim "$(extern vim/bundle/neobundle.vim)"
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

for f in dot/*; do
  tgt="$HOME/.$(basename $f)"
  if [[ -d "$tgt" && ! -L "$tgt" ]]; then
    for f2 in $f/*; do link "$PWD/$f2" "$tgt/$(basename $f2)"; done
  else
    link "$PWD/$f" "$tgt"
  fi
done

[[ ! -d "$HOME/bin" ]] && mkdir -p "$HOME/bin"
for b in bin/*; do link "$PWD/$b" "$HOME/$b"; done

function hask_link () {
  dir="$(extern haskell/$1/.cabal-sandbox/bin)"; shift
  [[ -d "$dir" ]] && {
    for f in "$@"; do
      link "$dir/$f" "$HOME/bin/$f"
    done
  }
}

hask_link dbmigrations moo
hask_link ghc-mod ghc-mod ghc-modi hlint
hask_link hoogle hoogle
hask_link xmonad xmonad

XDGCONFIG=${XDG_CONFIG_HOME-$HOME/.config}
[[ ! -d "$XDGCONFIG" ]] && mkdir -p "$XDGCONFIG"
for p in $PWD/xdg/*; do link "$p" "$XDGCONFIG/$(basename $p)"; done

link "$(extern vim/bundle)" "$PWD/dot/vim/bundle"
link "$(extern style/solarized-xresources/solarized)" "$HOME/.Xresources"

link "$HOME/.Xresources" "$HOME/.Xresources-x2go"
link "$HOME/.xsession" "$HOME/.xsession-x2go"
link "$HOME/.xsessionrc" "$HOME/.xsessionrc-x2go"

