. $(dirname $0)/_func.sh

if is_osx ;then
  brew install tmux
else
  echo "TODO"
fi

cp $(dirname $0)/tmux/tmux.conf ~/.tmux.conf
touch ~/.tmux.conf.local

local_conf=".tmux.conf.local"
if is_osx ;then
  os_conf="tmux.conf.mac"
else
  os_conf="tmux.conf.ubuntu"
fi
cp $(dirname $0)/tmux/${os_conf} ~/.${os_conf}
grep -sq ".${os_conf}" ~/${local_conf} && echo "source-file ~/.${os_conf}" >> ~/${local_conf}

