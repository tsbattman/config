#! /usr/bin/env zsh

typeset -U path
path=($HOME/bin $HOME/.cabal/bin $HOME/.local/bin $path)

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

