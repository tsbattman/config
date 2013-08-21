#! /usr/bin/env

export PAGER=less

bindkey -v

autoload -U compinit; compinit
autoload -U zmv;

PROMPT="%n@%m %# "
RPS1="%{${fg[blue]}%}%2~%{${fg[white]}%}"

export EDITOR="vim"
alias ls='ls --color'
export LESS="-FRSX --tabs=2"
[[ -x /usr/bin/lesspipe ]] && eval $(lesspipe)

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

function myproc() { ps -aef | grep "^$USER" }

function executable() { which $1 >> /dev/null && [[ -x `which $1` ]] }

if [[ -n "$DISPLAY" ]] && executable xrdb; then xrdb ~/.Xresources; fi

