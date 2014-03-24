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

mkdir -p "$HOME/thirdparty/vim" "$HOME/thirdparty/style"
if executable git; then
  gitdl http://github.com/Shougo/neobundle.vim "$HOME/thirdparty/vim/bundle/neobundle.vim"
  gitdl http://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  link "$HOME/thirdparty/vim/bundle" "dot/vim/bundle"
  gitdl http://github.com/chriskempson/base16-xresources.git "$HOME/thirdparty/style/base16-xresources"
  if is_bsd; then
    gitdl http://github.com/chriskempson/base16-iterm2.git "$HOME/thirdparty/style/base16-iterm2"
  fi
fi

for f in dot/*; do link "$PWD/$f" "$HOME/.$(basename $f)"; done

[[ ! -d "$HOME/bin" ]] && mkdir -p "$HOME/bin"
for b in bin/*; do link "$PWD/$b" "$HOME/$b"; done

XDGCONFIG=${XDG_CONFIG_HOME-$HOME/.config}
[[ ! -d "$XDGCONFIG" ]] && mkdir -p "$XDGCONFIG"
for p in $PWD/xdg/*; do link "$p" "$XDGCONFIG/$(basename $p)"; done

link "$HOME/.Xresources" "$HOME/.Xresources-x2go"
link "$HOME/.xsession" "$HOME/.xsession-x2go"
link "$HOME/.xsessionrc" "$HOME/.xsessionrc-x2go"

link "$HOME/thirdparty/style/base16-xresources/base16-default.dark.xresources" "$HOME/.Xresources"
