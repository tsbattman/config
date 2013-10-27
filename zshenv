#! /usr/bin/env zsh

function executable() { which $1 >> /dev/null && [[ -x `which $1` ]] }
function is_bsd() { [[ `uname` = 'Darwin' ]] }
function init_path() {
  if is_bsd; then
    local PYBIN=$HOME/Library/Python/2.7/bin
  else
    local PYBIN=$HOME/.local/bin
  fi
  typeset -gU path; path=($HOME/bin $HOME/.cabal/bin $PYBIN $path); export path
}
function init_aws() {
  local AWS_CONFIG=$HOME/thirdparty/aws-config.ini
  [[ -f $AWS_CONFIG ]] && export AWS_CONFIG_FILE=$AWS_CONFIG
}

init_path
init_aws

typeset -T PYTHONPATH pythonpath
pythonpath=($HOME/code/prcore $pythonpath)
export PRPATH=file://$HOME/code
export JAVA_HOME=/usr
export LANG=en_US.UTF-8

limit coredumpsize unlimited

