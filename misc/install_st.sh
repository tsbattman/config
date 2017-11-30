#! /usr/bin/env bash

BASE="$HOME/thirdparty"
mkdir -p "$BASE/suckless"

cd "$BASE/suckless"

[[ -d "st" ]] || git clone https://git.suckless.org/st

# patches are applied in order
patches=(solarized/st-no_bold_colors-20170623-b331da5.diff
  solarized/st-solarized-dark-20170623-b331da5.diff
  scrollback/st-scrollback-mouse-20170427-5a10aca.diff
  scrollback/st-scrollback-20170329-149c0d3.diff
  scrollback/st-scrollback-mouse-altscreen-20170427-5a10aca.diff
  )

for pi in "${patches[@]}"; do
  [[ -e "$(basename $pi)" ]] || wget "https://st.suckless.org/patches/$pi"
done

cd st
for pi in "${patches[@]}"; do
  git apply "../$(basename $pi)"
done

echo <<HERE
in config.def.h
  - change font (currently uses Droid Sans Mono with pixelsize=15)
  - change config.mk: PREFIX = $(HOME)/.local
  - on freebsd, need to use infotocap to convert st.info into cap file and import that
HERE
