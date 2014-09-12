#! /usr/bin/env zsh

fnm=Anonymous-Pro.zip
pth="$HOME/thirdparty/style/fonts/$fnm"

if [[ ! -e "$pth" ]]; then
  mkdir -p `dirname $pth`
  curl -o "$pth" "http://www.fontsquirrel.com/fonts/download/Anonymous-Pro"
fi

mkdir -p ~/.fonts
pushd ~/.fonts
unzip "$pth"
popd
fc-cache -v -f

