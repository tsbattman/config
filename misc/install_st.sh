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

# in config.def.h
#  - change font (currently uses Droid Sans Mono with pixelsize=15)
#  - change config.mk: PREFIX = $(HOME)/.local
#  - on freebsd install ncurses, use infotocap to st.info into st.cap run cap_mkdb /usr/share/misc/termcap st.cap


make
