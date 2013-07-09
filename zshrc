#! /usr/bin/env

export LESS="-FRSX --tabs=2"
export PAGER=less

bindkey -e

autoload -U compinit; compinit

PROMPT="%n@%m %# "
RPS1="%{${fg[blue]}%}%2~%{${fg[white]}%}"

export EDITOR="vim"
alias ls='ls --color'
alias rxvt='rxvt -fg white -bg black'

setopt NO_BEEP
setopt AUTO_CD
setopt EXTENDED_GLOB
setopt CORRECT
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt NO_HIST_BEEP

function cd () { builtin cd $1; ls; }
function pushd () { builtin pushd $1; ls; }
function popd () { builtin popd $1; ls; }
function rmtilda () { rm *~ }

