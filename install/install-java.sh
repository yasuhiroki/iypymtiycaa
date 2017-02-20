#!/bin/bash

. $(dirname $0)/_func.sh

type java >/dev/null || {
  if is_debian; then
    apt -y install openjdk-8-jre
  fi
}
