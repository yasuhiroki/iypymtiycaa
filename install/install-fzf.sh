#!/bin/bash

. $(dirname $0)/_func.sh

if [ -d ~/.fzf ]; then
  (
  cd ~/.fzf
  git pull
  )
else
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
fi

is_installed fzf >/dev/null || ~/.fzf/install --all

update_rc $(dirname $0)/rc/fzfrc.sh
