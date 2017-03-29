#!/bin/bash

. $(dirname $0)/../_func.sh
. $(dirname $0)/_func.sh

is_installed_asdf || { echo "No install asdf"; exit 1; }

if is_osx; then
  is_installed "gpg" || brew install gnupg2
fi

param=(\
  "nodejs"\
  "6.10.1"\
  "https://github.com/asdf-vm/asdf-nodejs.git"\
  )

default_install ${param[@]}

npm install -g npm
npm install -g https://yarnpkg.com/latest.tar.gz
