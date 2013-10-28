#! /usr/bin/env zsh

CONFIG_DIR=$HOME
if [[ `uname` = 'Darwin' ]]; then OPTS='-sfhF';
else OPTS='-sfT'; fi

mkdir -p $CONFIG_DIR/thirdparty/vim
if executable git; then
  [[ ! -d $CONFIG_DIR/thirdparty/vim/vim-pathogen ]] && git clone https://github.com/tpope/vim-pathogen.git $CONFIG_DIR/thirdparty/vim/vim-pathogen
  [[ ! -d $CONFIG_DIR/thirdparty/vim/vim-colors-solarized ]] && git clone https://github.com/altercation/vim-colors-solarized.git $CONFIG_DIR/thirdparty/vim/vim-solarized
  [[ ! -d $CONFIG_DIR/.oh-my-zsh ]] && git clone http://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

for f in `\ls`; do
  if [ "$f" = "configmapper.sh" ] || [ "$f" = "bin" ]; then continue; fi
  ln $OPTS  $PWD/$f $CONFIG_DIR/.$f
done

[[ ! -d $CONFIG_DIR/bin ]] && mkdir -p $CONFIG_DIR/bin
for b in `\ls bin`; do ln $OPTS $PWD/bin/$b $CONFIG_DIR/bin/$b; done

