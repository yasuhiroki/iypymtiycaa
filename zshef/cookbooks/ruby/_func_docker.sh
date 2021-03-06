#!/usr/bin/env zsh

source ${${(%):-%N}:A:h}/../docker/_func.sh

function my::ruby::docker::img() {
    echo "yasuhiroki/ruby:alpine"
}

function my::ruby::docker::run::cmd() {
    local v=(\
        "-i" \
        "--rm" \
        "-e BUNDLE_APP_CONFIG" \
        "-v $HOME/mybin/volume/ruby:/usr/local/bundle/:delegated" \
    )
    echo ${v[@]}
}

function my::ruby::docker::bin::dir() {
    echo "/usr/local/bin"
}

function my::ruby::local::bin::dir() {
    echo "${HOME}/mybin"
}

function my::install::docker() {
    zshef::util::mng::is_installed "docker" || {
        zshef::util::log::error "Depends docker"
        return 1
    }

    my::docker::build "ruby" "yasuhiroki/ruby:alpine"

    my::docker::language::init \
        "$(my::ruby::docker::img)" \
        "$(my::ruby::docker::run::cmd)" \
        "$(my::ruby::docker::bin::dir)" \
        "$(my::ruby::local::bin::dir)"

    my::docker::bin::create \
        "$(my::ruby::docker::img)" \
        "$(my::ruby::docker::run::cmd)" \
        "$(my::ruby::local::bin::dir)" \
        "rubysh" \
        "/bin/sh"
}

function my::install() {
    my::install::docker
}
