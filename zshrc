#! /usr/bin/env

export PAGER=less
export LESS="-FRSX --tabs=2"

bindkey -v
bindkey '^R' history-incremental-pattern-search-backward

zstyle :compinstall filename '/home/thayne/.zshrc'
autoload -Uz compinit; compinit
autoload -U zmv;

PROMPT="%n@%m %# "
RPS1="%{${fg[blue]}%}%2~%{${fg[white]}%}"

if is_bsd; then
  alias ls='ls -G'
else
  alias ls='ls --color'
fi
alias ll='ls -hl'

export EDITOR="vim"
alias lt='ll -rt'
alias grep='grep --color'
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
executable aws_zsh_completer.sh && source `which aws_zsh_completer.sh`
if [[ -n "$DISPLAY" ]] && executable xrdb; then xrdb ~/.Xresources; fi

