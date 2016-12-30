#!/bin/bash

script_dir=$(dirname $0)

. $(dirname $0)/_func.sh

if is_osx; then
  brew install zplug
elif is_debian; then
  curl -sL zplug.sh/installer | zsh
else
  echo "Not support"
  exit 1
fi

backup_lotation ~/.zshrc

cp ${script_dir}/zsh/zshrc ~/.zshrc
cp ${script_dir}/zsh/my-zshrc.zsh ~/.my-zshrc.zsh

exit 0
