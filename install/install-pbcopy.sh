#!/bin/bash

if [ "$(uname)" != 'Darwin' ]; then
    apt install xsel
    grep "^alias pobcopy.*" ~/.bash_aliases || echo "alias pbcopy='xsel --clipboard --input'" >> ~/.bash_aliases
fi
