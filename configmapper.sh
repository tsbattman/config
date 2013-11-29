#! /usr/bin/env zsh

CONFIG_DIR=$HOME
if [[ `uname` = 'Darwin' ]]; then OPTS='-sfhF';
else OPTS='-sfT'; fi

mkdir -p $CONFIG_DIR/thirdparty/vim $CONFIG_DIR/thirdparty/style
if executable git; then
  #[[ ! -d $CONFIG_DIR/thirdparty/vim/bundle/vundle ]] && git clone https://github.com/gmarik/vundle $CONFIG_DIR/thirdparty/vim/bundle/vundle
  [[ ! -d $CONFIG_DIR/thirdparty/vim/bundle/neobundle.vim ]] && git clone git://github.com/Shougo/neobundle.vim $CONFIG_DIR/thirdparty/vim/bundle/neobundle.vim
  [[ ! -d $CONFIG_DIR/.oh-my-zsh ]] && git clone http://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  pushd vim; ln $OPTS $CONFIG_DIR/thirdparty/vim/bundle bundle; popd
fi

for f in *; do
  if [ "$f" = "configmapper.sh" ] || [ "$f" = "bin" ]; then continue; fi
  ln $OPTS  $PWD/$f $CONFIG_DIR/.$f
done

[[ ! -d $CONFIG_DIR/bin ]] && mkdir -p $CONFIG_DIR/bin
for b in bin/*; do ln $OPTS $PWD/$b $CONFIG_DIR/$b; done

for f in $PWD/xdg/autostart/*; do
  ln $OPTS $f $CONFIG_DIR/.config/autostart/`basename $f`
done

