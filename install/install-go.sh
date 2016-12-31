#!/bin/bash

. $(dirname $0)/_func.sh

type gvm >/dev/null || {
  if is_debian; then
    sudo apt install curl git mercurial make binutils bison gcc build-essential
  fi
  bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
}

update_rc $(dirname $0)/../rc/gvm.sh
