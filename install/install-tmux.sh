. $(dirname $0)/_func.sh

if is_osx ;then
    brew install tmux
else
    echo "TODO"
fi

cp $(dirname $0)/tmux/tmux.conf ~/.tmux.conf
touch ~/.tmux.conf.local

