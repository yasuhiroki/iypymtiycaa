#!/bin/bash

script_dir=$(dirname $0)

. $(dirname $0)/_func.sh

if is_osx; then
  is_installed elixir || brew install elixir
elif is_debian; then
  echo "Not support"
  exit 1
else
  echo "Not support"
  exit 1
fi

exit 0
