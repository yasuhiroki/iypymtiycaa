#!/bin/bash

. $(dirname $0)/_func.sh

if is_osx; then
  brew install coreutils automake autoconf openssl libyaml readline libxslt libtool unixodbc
elif is_debian; then
  apt install -y automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev
fi

[ ! -d ~/.asdf ] && git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.2.1

update_rc $(dirname $0)/rc/asdfrc.sh
