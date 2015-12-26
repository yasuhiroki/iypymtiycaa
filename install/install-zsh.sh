#!/bin/bash

if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

cp zsh/my-zshrc.zsh ~/.oh-my-zsh/custom/

