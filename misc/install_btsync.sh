#! /usr/bin/env zsh

source install_helpers.sh

DIR=$(extern bittorrent/sync)
fnm='bittorrent_sync_x64.tar.gz'
fetch "$DIR/$fnm" "http://download-new.utorrent.com/endpoint/btsync/os/linux-x64/track/stable"

pushd "$DIR"
gzip -dc "$fnm"  | tar xvf -
popd
