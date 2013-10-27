#! /usr/bin/env

# oh my zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="random"
plugins=(git svn colored-man)
CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
source $ZSH/oh-my-zsh.sh

# my stuff
export LESS="-FRSX --tabs=2"

# use  oh-my-zsh for now
#bindkey -v
#bindkey '^R' history-incremental-pattern-search-backward
#PROMPT="%n@%m %# "
#RPS1="%{${fg[blue]}%}%2~%{${fg[white]}%}"

export EDITOR="vim"
alias lt='ll -rt'
setopt NO_BEEP
setopt EXTENDED_GLOB
setopt CORRECT
setopt HIST_IGNORE_ALL_DUPS
setopt NO_HIST_BEEP

function cd () { builtin cd $1; ls; }
function pd () { builtin pushd $1; ls; }
function myproc() { ps -aef | grep "^$USER" }

executable lesspipe && eval $(lesspipe)
executable aws_zsh_completer.sh && source `which aws_zsh_completer.sh`
[[ -n "$DISPLAY" ]] && executable xrdb && xrdb ~/.Xresources


