#! /usr/bin/env zsh

function executable() { which $1 >> /dev/null && [[ -x `which $1` ]] }
function is_bsd() { [[ `uname` = 'Darwin' ]] }
function init_path() {
  typeset -a bins
  if is_bsd; then
    bins=($HOME/Library/Python/2.7/bin $HOME/Library/Haskell/bin)
  else
    bins=($HOME/.local/bin $HOME/.cabal/bin)
  fi
  typeset -gU path; path=($HOME/bin $bins $path $HOME/code/prcore)
}
function init_aws() {
  local AWS_CONFIG=$HOME/thirdparty/aws-config.ini
  [[ -f $AWS_CONFIG ]] && export AWS_CONFIG_FILE=$AWS_CONFIG
}

init_path
init_aws

typeset -T -U PYTHONPATH pythonpath
pythonpath=($HOME/code/prcore $pythonpath)
export PYTHONPATH
export JAVA_HOME=/usr
export LANG=en_US.UTF-8

limit coredumpsize unlimited

[[ -s $HOME/.nvm/nvm.sh ]] && source $HOME/.nvm/nvm.sh && nvm use v0.10.21 &> /dev/null
