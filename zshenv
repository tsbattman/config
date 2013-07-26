#! /usr/bin/env zsh

if [ -z "$ZSHENVD" ]; then export ZSHENVD=1;
else exit; fi

export PATH=$HOME/bin:$HOME/.cabal/bin:$PATH
export PYTHONPATH=$HOME/code/prcore:$PYTHONPATH
export PRPATH=file://$HOME/code

ulimit -c unlimited

