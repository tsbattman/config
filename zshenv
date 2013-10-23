#! /usr/bin/env zsh

if [ -z "$ZSHENVD" ]; then export ZSHENVD=1;
else; return; fi

export PYTHONPATH=$HOME/code/prcore:$PYTHONPATH
export PRPATH=file://$HOME/code
export JAVA_HOME=/usr

limit coredumpsize unlimited
#limit addressspace $((5*1024))m

# AWS
EC2_VERSION=1.6.11.0
EC2_HOME=$HOME/thirdparty/ec2-api-tools-$EC2_VERSION
if [[ -d $EC2_HOME ]]; then
  export EC2_HOME
  export AWS_ACCESS_KEY=`cat $HOME/thirdparty/ec2-access.key`
  export AWS_SECRET_KEY=`cat $HOME/thirdparty/ec2-secret.key`
  export PATH=$EC2_HOME/bin:$PATH
fi

export PATH=$HOME/bin:$HOME/.cabal/bin:$PATH
