#! /usr/bin/env bash

BASE="$HOME/thirdparty"
mkdir -p "$BASE/suckless"

cd "$BASE/suckless"

[[ -d "st" ]] || git clone https://git.suckless.org/st

# patches are applied in order
patches=(solarized/st-no_bold_colors-0.8.1.diff
  solarized/st-solarized-dark-20180411-041912a.diff
  scrollback/st-scrollback-20181224-096b125.diff
  scrollback/st-scrollback-mouse-0.8.diff
  )

for pi in "${patches[@]}"; do
  [[ -e "$(basename $pi)" ]] || wget "https://st.suckless.org/patches/$pi"
done

cd st
# for pi in "${patches[@]}"; do
#   git apply "../$(basename $pi)"
# done

echo <<HERE
in config.def.h
  - change font (currently uses Droid Sans Mono with pixelsize=15)
  - change config.mk: PREFIX = $HOME/.local
  - on freebsd, need to use infotocap to convert st.info into cap file and import that
  - add to main in x.c
    - setlocale(LC_CTYPE, "en_US.UTF-8")
    - XSetLocaleModifiers("@im=ibus")
HERE
