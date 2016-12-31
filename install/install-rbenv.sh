#!/bin/bash

. $(dirname $0)/_func.sh

if is_debian; then
  sudo apt install -y git autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
fi

echo "Install rbenv"
if [ -d ~/.rbenv ]; then
  (
  cd ~/.rbenv
  git pull
  )
else
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
fi

if [ -d ~/.rbenv/plugins/ruby-build ]; then
  (
  cd ~/.rbenv/plugins/ruby-build
  git pull
  )
else
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

