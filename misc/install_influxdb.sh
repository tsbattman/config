#! /usr/bin/env zsh

source install_helpers.sh

DIR=$(extern influxdb)
fnm=influxdb_latest_amd64.deb
fetch "$DIR/$fnm" "http://s3.amazonaws.com/influxdb/$fnm"

pushd "$DIR"
sudo dpkg -i "$fnm"
popd
