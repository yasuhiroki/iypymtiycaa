#!/usr/bin/env zsh

source ${${(%):-%N}:A:h}/../asdf/_func.sh

function my::install::asdf() {
    zshef::util::mng::is_installed "asdf" || {
        zshef::util::log::error "Depends asdf"
        return 1
    }

    my::asdf::is_installed "go" || {
        param=( \
          "go" \
          "1.9.6" \
          "https://github.com/kennyp/asdf-golang.git" \
        )

        my::asdf::default_install ${param[@]}
    }
}

function my::install () {
    my::install::asdf
}

function my::config() {
    :
}
