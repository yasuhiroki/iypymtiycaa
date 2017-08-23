#!/usr/bin/env zsh

source ${${(%):-%N}:A:h}/../docker/_func.sh

function my::nodejs::docker::img() {
    echo "yasuhiroki/node:alpine"
}

function my::nodejs::docker::run::cmd() {
    local v=(\
        "-i" \
        "--rm" \
        "-v $HOME/mybin/volume/nodejs/node_modules:/node_modules:delegated" \
        "-v /usr/local/lib/node_modules/npm"
    )
    echo ${v[@]}
}

function my::nodejs::docker::bin::dir() {
    echo "/usr/local/bin"
}

function my::nodejs::local::bin::dir() {
    echo "${HOME}/mybin"
}

function my::install::docker() {
    zshef::util::mng::is_installed "docker" || {
        zshef::util::log::error "Depends docker"
        return 1
    }

    my::docker::build "nodejs" "$(my::nodejs::docker::img)"

    my::docker::language::init \
        "$(my::nodejs::docker::img)" \
        "$(my::nodejs::docker::run::cmd)" \
        "$(my::nodejs::docker::bin::dir)" \
        "$(my::nodejs::local::bin::dir)"

    my::docker::bin::create \
        "$(my::nodejs::docker::img)" \
        "$(my::nodejs::docker::run::cmd)" \
        "$(my::nodejs::local::bin::dir)" \
        "nodesh" \
        "/bin/sh"

    my::docker::bin::create \
        "$(my::nodejs::docker::img)" \
        "$(my::nodejs::docker::run::cmd)" \
        "$(my::nodejs::local::bin::dir)" \
        "gnpm" \
        "npm"

    my::config
}

function my::config() {
    :
}

function my::install () {
    my::install::asdf
}
