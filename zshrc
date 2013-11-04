#! /usr/bin/env

# oh my zsh
# git clone http://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="random"
#ZSH_THEME="junkfood"
plugins=(git svn cabal colored-man)
CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
source $ZSH/oh-my-zsh.sh

# my stuff
autoload zmv
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
executable dircolors && [[ -f $HOME/.dircolors ]] && eval $(dircolors $HOME/.dircolors)
[[ -n "$DISPLAY" ]] && executable xrdb && xrdb ~/.Xresources
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh

function svndiff() { svn diff "$@" | pygmentize -l diff }
function gitdiff() { git diff "$@" | pygmentize -l diff }
