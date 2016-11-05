#!/bin/bash

. $(dirname $0)/_func.sh

if is_debian ;then
  apt install xsel
fi
