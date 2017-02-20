#!/bin/bash

. $(dirname $0)/_func.sh

if is_osx ;then
  brew install graphviz
else
  sudo apt -y install graphviz
fi

