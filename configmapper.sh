#! /bin/sh

if [[ `uname` = 'Darwin' ]]; then opts='-sfF';
else opts='-sfT'; fi

CONFIG_DIR=$HOME

for f in `ls`; do
  if [ "$f" = "configmapper.sh" ] || [ "$f" = "bin" ] || [ -e $CONFIG_DIR/.$f ]; then
    continue
  fi
  ln $OPTS  $PWD/$f $CONFIG_DIR/.$f
done

if [ ! -d $CONFIG_DIR/bin ]; then mkdir -p $CONFIG_DIR/bin; fi

for b in `ls bin`; do
  ln $OPTS $PWD/bin/$b $CONFIG_DIR/bin/$b
done
