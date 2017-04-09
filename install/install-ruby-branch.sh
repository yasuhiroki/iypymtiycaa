#!/bin/bash

. $(dirname $0)/_func.sh

version="${1:-trunk}"

source_dir=".ruby"
[ ! -d ~/${source_dir} ] && git clone https://github.com/ruby/ruby.git ~/${source_dir}

if is_osx; then
  BUILD_OPT="--enable-shared --with-readline-dir=$(brew --prefix readline) --with-openssl-dir=$(brew --prefix openssl)"
fi

(
  cd ~/${source_dir}
  git clean -xdf
  git checkout ${version}
  git pull
  autoconf
  ./configure --prefix=$HOME/.rbenv/versions/${version} ${BUILD_OPT} --enable-debug-env CPPFLAGS='-DRUBY_DEBUG_ENV -DARRAY_DEBUG'
  make
  make check
  make install
)

