#! /bin/sh

SDIR="$HOME/thirdparty/sfnettest"
VER=1.5.0
PKG="sfnettest-$VER"
TAR="$PKG.tgz"

[[ -d "$SDIR" ]] || mkdir -p "$SDIR"
[[ -f "$SDIR/$TAR" ]] || curl -o "$SDIR/$TAR" "http://www.openonload.org/download/sfnettest/$TAR"
[[ -d "$SDIR/$PKG" ]] || gzip -dc "$SDIR/$TAR" | (cd "$SDIR"; tar xvf -)

pushd $SDIR/$PKG/src
make
popd

