#! /usr/bin/env

function executable() { which $1 >> /dev/null && [[ -x `which $1` ]] }
function is_bsd() { [[ `uname` = 'Darwin' ]] }


export PAGER=less

bindkey -v
bindkey '^R' history-incremental-pattern-search-backward

zstyle :compinstall filename '/home/thayne/.zshrc'
autoload -Uz compinit; compinit
autoload -U zmv;

PROMPT="%n@%m %# "
RPS1="%{${fg[blue]}%}%2~%{${fg[white]}%}"

export EDITOR="vim"
if is_bsd; then alias ls='ls -G';
else alias ls='ls --color'; fi
alias ll='ls -hl'
alias lt='ll -rt'
alias grep='grep --color'
export LESS="-FRSX --tabs=2"

setopt NO_BEEP
setopt AUTO_CD
setopt EXTENDED_GLOB
setopt CORRECT
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt NO_HIST_BEEP

function cd () { builtin cd $1; ls; }
function pd () { builtin pushd $1; ls; }
function myproc() { ps -aef | grep "^$USER" }


executable lesspipe && eval $(lesspipe)
if [[ -n "$DISPLAY" ]] && executable xrdb; then xrdb ~/.Xresources; fi

