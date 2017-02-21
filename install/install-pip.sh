#!/bin/bash

. $(dirname $0)/_func.sh

is_installed "pip" || {
  if is_debian; then
    apt -y install python-pip
  fi
}
