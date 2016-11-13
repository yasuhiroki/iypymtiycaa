#!/bin/bsah

. $(dirname $0)/_func.sh

if is_debian; then
  sudo apt-get install curl git mercurial make binutils bison gcc build-essential
  bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
fi
