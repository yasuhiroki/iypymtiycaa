#!/bin/bash

. $(dirname $0)/_func.sh

is_installed_asdf || { echo "No install asdf"; exit 1; }

param=(\
  "python"\
  "3.5.3"\
  "https://github.com/tuvistavie/asdf-python.git"\
  )

default_install ${param[@]}

