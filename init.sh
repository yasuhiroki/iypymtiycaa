#!/usr/bin/env zsh

set -eu

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || brew -v

mkdir -p ~/ghq/github.com/yasuhiroki/
git clone git@github.com:yasuhiroki/iypymtiycaa ~/ghq/github.com/yasuhiroki/
git clone git@github.com:yasuhiroki/zshef ~/ghq/github.com/yasuhiroki/

mkdir -p ~/.iypymtiycaa
mkdir -p ~/mybin

(
cd ~/ghq/github.com/yasuhiroki/iypymtiycaa/zshef
source ../../zshef/init.sh
zshef install
zshef config
)



