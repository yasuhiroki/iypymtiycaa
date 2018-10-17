#!/usr/bin/env zsh

source ${${(%):-%N}:A:h}/../asdf/_func.sh

function my::install::asdf() {
    my::asdf::is_installed "ruby" || {
        local param=(\
            "ruby" \
            "2.5.1" \
            "https://github.com/asdf-vm/asdf-ruby.git" \
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
