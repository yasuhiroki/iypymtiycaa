#!/bin/bash

version="${1:-trunk}"

source_dir=".ruby"
[ ! -d ~/${source_dir} ] && git clone https://github.com/ruby/ruby.git ~/${source_dir}

(
  cd ~/${source_dir}
  git clean -xdf
  git checkout ${version}
  git pull
  autoconf
  ./configure --prefix=$HOME/.rbenv/versions/${version} --enable-shared --enable-debug-env CPPFLAGS='-DRUBY_DEBUG_ENV -DARRAY_DEBUG'
  make
  make check
  make install
)

