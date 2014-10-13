
function extern() { echo "$HOME/thirdparty/$1" }

function fetch() {
  pth="$1"; url="$2"
  if [[ ! -e "$pth" ]]; then
    if [[ ! -d `dirname "$pth"` ]]; then
      mkdir -p `dirname "$pth"`
    fi
    curl -o "$pth" "$url"
  fi
}

