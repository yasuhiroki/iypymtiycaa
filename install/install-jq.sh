#!/bin/bash

. $(dirname $0)/_func.sh

is_installed "jq" || {
  if is_osx; then
    brew install jq
  elif is_debian; then
    apt -y install jq
  fi
}
