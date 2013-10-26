#! /usr/bin/env zsh

function executable() { which $1 >> /dev/null && [[ -x `which $1` ]] }
function is_bsd() { [[ `uname` = 'Darwin' ]] }

if is_bsd; then
  PYBIN=$HOME/Library/Python/2.7/bin
else
  PYBIN=$HOME/.local/bin
fi
typeset -U path
path=($HOME/bin $HOME/.cabal/bin $PYBIN $path)

export PYTHONPATH=$HOME/code/prcore:$PYTHONPATH
export PRPATH=file://$HOME/code
export JAVA_HOME=/usr

limit coredumpsize unlimited
#limit addressspace $((5*1024))m

# AWS
EC2_ACCESS=$HOME/thirdparty/ec2-access.key
EC2_SECRET=$HOME/thirdparty/ec2-secret.key
[[ -f $EC2_ACCESS ]] && export AWS_ACCESS_KEY=`cat $EC2_ACCESS`
[[ -f $EC2_SECRET ]] && export AWS_SECRET_KEY=`cat $EC2_SECRET`

