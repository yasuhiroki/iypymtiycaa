#!/bin/bsah

install_dir=".enhancd"

if [ -d ~/${install_dir} ]; then
    (
    cd ~/${install_dir}
    git pull
    )
else
    git clone https://github.com/b4b4r07/enhancd.git ~/${install_dir}
fi

if [ "$(uname)" == 'Darwin' ]; then
    brew install peco
else
    echo "go get github.com/peco/peco/cmd/peco"
fi

rc=".enhancdrc"
echo "Init ${rc}"
echo "ENHANCD_COMMAND='cd'
source ~/${install_dir}/enhancd.sh
" > ~/${rc}
[ -f ~/.bashrc ] && grep -sq "^source.*${rc}$" ~/.bashrc || echo "source ~/${rc}" >> ~/.bashrc
[ -f ~/.zshrc ]  && grep -sq "^source.*${rc}$" ~/.zshrc || echo "source ~/${rc}" >> ~/.zshrc


