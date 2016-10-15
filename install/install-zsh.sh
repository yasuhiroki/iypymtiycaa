#!/bin/bash

script_dir=$(dirname $0)

if [ ! -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

cp ${script_dir}/zsh/my-zshrc.zsh ~/.oh-my-zsh/custom/


#zsh-autosuggestions
if [ $ZSH_CUSTOM ] && [ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]; then
  git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi


