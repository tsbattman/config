#! /usr/bin/env zsh

source install_helpers.sh

VER=1.7.0
DIR=$(extern grafana)
fnm="grafana-${VER}.tar.gz"
fetch "$DIR/$fnm" "http://grafanarel.s3.amazonaws.com/$fnm"

pushd "$DIR"
gzip -dc "$fnm" | tar xvf -
popd

