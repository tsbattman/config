#! /usr/bin/env zsh

CONFIG_DIR=$HOME
if [[ $(uname) = 'Darwin' ]]; then OPTS='-sfhF';
else OPTS='-sfT'; fi

function gitdl() {
  src=$1; des=$2
  if [[ -d $des ]]; then
    pushd "$des"; git pull origin master; popd
  else
    git clone "$src" "$des"
  fi
}

mkdir -p "$CONFIG_DIR/thirdparty/vim" "$CONFIG_DIR/thirdparty/style"
if executable git; then
  gitdl http://github.com/Shougo/neobundle.vim "$CONFIG_DIR/thirdparty/vim/bundle/neobundle.vim"
  gitdl http://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  pushd dot/vim; ln $OPTS "$CONFIG_DIR/thirdparty/vim/bundle" bundle; popd
fi

pushd dot
for f in *; do ln "$OPTS"  "$PWD/$f" "$CONFIG_DIR/.$f"; done
popd

[[ ! -d "$CONFIG_DIR/bin" ]] && mkdir -p "$CONFIG_DIR/bin"
for b in bin/*; do ln "$OPTS" "$PWD/$b" "$CONFIG_DIR/$b"; done

XDGCONFIG=${XDG_CONFIG_HOME-$HOME/.config}
echo $XDGCONFIG
for p in $PWD/xdg/*; do
  ln "$OPTS" "$p" "$XDGCONFIG/$(basename $p)"
done

