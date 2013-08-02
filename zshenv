#! /usr/bin/env zsh

if [ -z "$ZSHENVD" ]; then export ZSHENVD=1;
else; return; fi

export PATH=$HOME/bin:$HOME/.cabal/bin:$PATH
export PYTHONPATH=$HOME/code/prcore:$PYTHONPATH
export PRPATH=file://$HOME/code

limit coredumpsize unlimited
limit addressspace $((5*1024))m
