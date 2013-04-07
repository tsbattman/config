#! /bin/sh

CONFIG_DIR=$HOME

for f in `ls`; do
  if [ "$f" = "configmapper.sh" ] || [ -e $HOME/.$f ]; then
    continue
  fi
  ln -sfT  $PWD/$f $CONFIG_DIR/.$f
done
