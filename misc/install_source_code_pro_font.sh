#! /bin/sh

fnm=SourceCodePro_FontsOnly-1.017.zip
pth="$HOME/thirdparty/style/fonts/$fnm"

if [[ ! -e "$pth" ]]; then
  mkdir -p `dirname $pth`
  curl -o "$pth" "http://nchc.dl.sourceforge.net/project/sourcecodepro.adobe/$fnm"
fi

mkdir -p ~/.fonts
pushd ~/.fonts
unzip "$pth"
popd
fc-cache -v -f

