#!/usr/bin/env zsh

set -eu

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || brew -v

./init.sh
