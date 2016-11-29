#!/bin/bash

install_dir=".enhancd"

if [ -d ~/${install_dir} ]; then
  (
  cd ~/${install_dir}
  git pull
  )
else
  git clone https://github.com/b4b4r07/enhancd.git ~/${install_dir}
fi

echo "Install fzf"
bash $(dirname $0)/install-fzf.sh

rc=".enhancdrc"
echo "Init ${rc}"
echo "ENHANCD_COMMAND='cd'
source ~/${install_dir}/init.sh
" > ~/${rc}

