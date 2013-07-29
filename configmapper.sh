#! /bin/sh

CONFIG_DIR=$HOME

for f in `ls`; do
  if [ "$f" = "configmapper.sh" ] || [ "$f" = "bin" ] || [ -e $CONFIG_DIR/.$f ]; then
    continue
  fi
  ln -sfT  $PWD/$f $CONFIG_DIR/.$f
done

if [ ! -d $CONFIG_DIR/bin ]; then mkdir -p $CONFIG_DIR/bin; fi

for b in `ls bin`; do
  ln -sfT $PWD/bin/$b $CONFIG_DIR/bin/$b
done
