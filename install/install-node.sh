#!/bin/bash

# My node development
#  - Install manager: nvm
#  - Package manager: npm/yarn

. $(dirname $0)/_func.sh

# Install NVM
if [ -z "$NVM_DIR" ]; then
  curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
else
  (
  cd "$NVM_DIR"
  git fetch origin
  git checkout master
  git pull
  ) && . "$NVM_DIR/nvm.sh"
fi

update_rc $(dirname $0)/../rc/nvmrc.sh


if is_osx ;then
  type yarn >/dev/null || brew install yarn
else
  type yarn >/dev/null || curl -o- -L https://yarnpkg.com/install.sh | bash
fi

update_rc $(dirname $0)/../rc/yarnrc.sh
