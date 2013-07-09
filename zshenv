
if [ -z "$RCD" ]; then RCD=1;
else exit; fi

export PATH=$HOME/bin:$HOME/.cabal/bin:$PATH
export PYTHONPATH=file://$HOME/code/pcore
export PRPATH=file://$HOME/code
export LESS="-FRSX --tabs=2"

[ -x /usr/bin/lesspipe ] || eval $(lesspipe)
