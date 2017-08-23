#!/usr/bin/env zsh

source ${${(%):-%N}:A:h}/../docker/_func.sh

function my::golang::docker::img() {
    echo "yasuhiroki/golang:alpine"
}

function my::golang::docker::run::cmd() {
    local v=(\
        "-i" \
        "--rm" \
        "-v mygolang:/go" \
    )
    echo ${v[@]}
}

function my::golang::docker::bin::dir() {
    echo "/usr/local/go/bin"
}

function my::golang::local::bin::dir() {
    echo "${HOME}/mybin"
}

function my::install::docker() {
    zshef::util::mng::is_installed "docker" || {
        zshef::util::log::error "Depends docker"
        return 1
    }

    my::docker::build "golang" "$(my::golang::docker::img)"

    my::docker::language::init \
        "$(my::golang::docker::img)" \
        "$(my::golang::docker::run::cmd)" \
        "$(my::golang::docker::bin::dir)" \
        "$(my::golang::local::bin::dir)"

    my::docker::bin::create \
        "$(my::golang::docker::img)" \
        "$(my::golang::docker::run::cmd)" \
        "$(my::golang::local::bin::dir)" \
        "gosh" \
        "/bin/sh"

    my::docker::language::init \
        "$(my::golang::docker::img)" \
        "$(my::golang::docker::run::cmd)" \
        "/go/bin" \
        "$(my::golang::local::bin::dir)"
}

function my::install () {
    my::install::docker
}

function my::config() {
    :
}
