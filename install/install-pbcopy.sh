#!/bin/bash

. $(dirname $0)/_func.sh

if is_debian ;then
  sudo apt -y install xsel
fi
