#!/bin/bash

. $(dirname $0)/_func.sh

if is_osx ;then
  is_installed tmux || brew install tmux
else
  sudo apt -y install tmux
fi

cp $(dirname $0)/tmux/tmux.conf ~/.tmux.conf
touch ~/.tmux.conf.local

local_conf=".tmux.conf.local"
if is_osx; then
  os_conf="tmux.conf.mac"
else
  os_conf="tmux.conf.ubuntu"
fi
cp $(dirname $0)/tmux/${os_conf} ~/.${os_conf}
echo "source-file ~/.${os_conf}" >> ~/${local_conf}

