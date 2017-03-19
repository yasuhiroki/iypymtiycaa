#!/bin/bash

. $(dirname $0)/_func.sh

is_installed_asdf || { echo "No install asdf"; exit 1; }

param=(\
  "elixir"\
  "1.4.2"\
  "https://github.com/asdf-vm/asdf-elixir.git"\
  )

default_install ${param[@]}

