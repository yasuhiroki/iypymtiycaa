#!/bin/bash

script_dir=$(dirname $0)

. $(dirname $0)/_func.sh

if is_osx; then
  is_installed zplug || brew install zplug
elif is_debian; then
  is_installed zplug || git clone https://github.com/zplug/zplug ~/.zplug
else
  echo "Not support"
  exit 1
fi

backup_lotation ~/.zshrc

if is_osx; then
  echo 'export ZPLUG_HOME=/usr/local/opt/zplug'  > ~/.zshrc
  echo 'source $ZPLUG_HOME/init.zsh'            >> ~/.zshrc
  echo ''                                       >> ~/.zshrc
elif is_debian; then
  echo 'source ~/.zplug/init.zsh'  > ~/.zshrc
  echo ''                         >> ~/.zshrc
fi
cat ${script_dir}/zsh/zshrc >> ~/.zshrc
cp ${script_dir}/zsh/my-zshrc.zsh ~/.my-zshrc.zsh

update_rc $(dirname $0)/rc/alias.sh

exit 0
