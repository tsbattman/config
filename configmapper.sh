#! /usr/bin/env zsh

function executable() { which $1 >> /dev/null && [[ -x `which $1` ]] }
function is_bsd() { [[ `uname` = 'Darwin' ]] }

if is_bsd; then function link() { src=$1; des=$2; ln -sfhF "$src" "$des" }
else function link() { src=$1; des=$2; ln -sfT "$src" "$des" } fi
function gitdl() {
  src=$1; des=$2
  if [[ -d $des ]]; then pushd "$des"; git pull origin master; popd
  else git clone "$src" "$des"; fi
}

CONFIG_DIR=$HOME
mkdir -p "$CONFIG_DIR/thirdparty/vim" "$CONFIG_DIR/thirdparty/style"
if executable git; then
  gitdl http://github.com/Shougo/neobundle.vim "$CONFIG_DIR/thirdparty/vim/bundle/neobundle.vim"
  gitdl http://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  link "$CONFIG_DIR/thirdparty/vim/bundle" "dot/vim/bundle"
  gitdl http://github.com/chriskempson/base16-xresources.git "$CONFIG_DIR/thirdparty/style/base16-xresources"
  if is_bsd; then
    gitdl http://github.com/chriskempson/base16-iterm2.git "$CONFIG_DIR/thirdparty/style/base16-iterm2"
  fi
fi

for f in dot/*; do link "$PWD/$f" "$CONFIG_DIR/.$(basename $f)"; done

[[ ! -d "$CONFIG_DIR/bin" ]] && mkdir -p "$CONFIG_DIR/bin"
for b in bin/*; do link "$PWD/$b" "$CONFIG_DIR/$b"; done

XDGCONFIG=${XDG_CONFIG_HOME-$HOME/.config}
[[ ! -d "$XDGCONFIG" ]] && mkdir -p "$XDGCONFIG"
for p in $PWD/xdg/*; do link "$p" "$XDGCONFIG/$(basename $p)"; done

link "$HOME/.Xresources" "$HOME/.Xresources-x2go"
link "$HOME/.xsession" "$HOME/.xsession-x2go"
link "$HOME/.xsessionrc" "$HOME/.xsessionrc-x2go"

