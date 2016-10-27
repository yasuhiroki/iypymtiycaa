#!/bin/bash

. $(dirname $0)/_func.sh

if is_debian ;then
  apt install xsel
  grep "^alias pobcopy.*" ~/.bash_aliases || echo "alias pbcopy='xsel --clipboard --input'" >> ~/.bash_aliases
fi
