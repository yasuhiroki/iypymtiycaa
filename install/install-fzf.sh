[ -d ~/.fzf ] && (cd ~/.fzf; git pull)
[ ! -d ~/.fzf ] && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

~/.fzf/install

cp $(dirname $0)/misc/fzfrc.sh ~/.fzfrc

