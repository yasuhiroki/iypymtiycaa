#!/bin/bash

if [ -d ~/.fzf ]; then
  (
  cd ~/.fzf
  git pull
  )
else
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
fi

~/.fzf/install

cp $(dirname $0)/misc/fzfrc.sh ~/.fzfrc

