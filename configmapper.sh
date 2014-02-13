#! /usr/bin/env zsh

CONFIG_DIR=$HOME
if [[ `uname` = 'Darwin' ]]; then OPTS='-sfhF';
else OPTS='-sfT'; fi

function gitdl() {
  src=$1; des=$2
  if [[ -d $des ]]; then
    pushd $des; git pull origin master; popd
  else
    git clone $src $des
  fi
}

mkdir -p $CONFIG_DIR/thirdparty/vim $CONFIG_DIR/thirdparty/style
if executable git; then
  gitdl http://github.com/Shougo/neobundle.vim $CONFIG_DIR/thirdparty/vim/bundle/neobundle.vim
  gitdl http://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  pushd dot/vim; ln $OPTS $CONFIG_DIR/thirdparty/vim/bundle bundle; popd
fi

pushd dot
for f in *; do; ln $OPTS  $PWD/$f $CONFIG_DIR/.$f; done
popd

[[ ! -d $CONFIG_DIR/bin ]] && mkdir -p $CONFIG_DIR/bin
for b in bin/*; do ln $OPTS $PWD/$b $CONFIG_DIR/$b; done

[[ ! -d $CONFIG_DIR/.config/autostart ]] && mkdir -p $CONFIG_DIR/.config/autostart
for f in $PWD/xdg/autostart/*; do
  ln $OPTS $f $CONFIG_DIR/.config/autostart/`basename $f`
done

