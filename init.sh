#!/usr/bin/env zsh

set -eu

GH_REPO_BASE_DIR="$HOME/.iypymtiycaa/init/"

mkdir -p "${GH_REPO_BASE_DIR}"
git clone https://github.com/yasuhiroki/iypymtiycaa "${GH_REPO_BASE_DIR}/iypymtiycaa"
git clone https://github.com/yasuhiroki/zshef "${GH_REPO_BASE_DIR}/zshef"

(
    cd "${GH_REPO_BASE_DIR}/iypymtiycaa/zshef"
    source ../../zshef/init.sh
    zshef install zsh asdf
    zshef config zsh asdf

    zshef install
    zshef config
)
