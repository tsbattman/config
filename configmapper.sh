#! /usr/bin/env zsh

CONFIG_DIR=$HOME
if [[ `uname` = 'Darwin' ]]; then OPTS='-sfhF';
else OPTS='-sfT'; fi

mkdir -p $CONFIG_DIR/thirdparty/vim
if executable git; then
  [[ ! -d $CONFIG_DIR/thirdparty/vim/bundle/vundle ]] && git clone https://github.com/gmarik/vundle $CONFIG_DIR/thirdparty/vim/bundle/vundle
  [[ ! -d $CONFIG_DIR/.oh-my-zsh ]] && git clone http://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  pushd vim; ln $OPTS $CONFIG_DIR/thirdparty/vim/bundle bundle; popd
fi

for f in `\ls`; do
  if [ "$f" = "configmapper.sh" ] || [ "$f" = "bin" ]; then continue; fi
  ln $OPTS  $PWD/$f $CONFIG_DIR/.$f
done

[[ ! -d $CONFIG_DIR/bin ]] && mkdir -p $CONFIG_DIR/bin
for b in `\ls bin`; do ln $OPTS $PWD/bin/$b $CONFIG_DIR/bin/$b; done

