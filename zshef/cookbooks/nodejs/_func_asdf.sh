#!/usr/bin/env zsh

source ${${(%):-%N}:A:h}/../asdf/_func.sh

function my::install::asdf() {
    zshef::util::mng::is_installed "asdf" || {
        zshef::util::log::error "Depends asdf"
        return 1
    }

    # TODO: install gpg when use OSX
    my::asdf::is_installed "nodejs" || {
        param=(\
          "nodejs"\
          "8.11.3"\
          "https://github.com/asdf-vm/asdf-nodejs.git"\
          )

        my::asdf::default_install ${param[@]}
        [ $? != 0 ] && return $?

        my::install::modules
        [ $? != 0 ] && return $?

        my::config
    }
}

function my::npm::global::modules() {
    echo eslint eslint-config-airbnb eslint-plugin-jsx-a11y eslint-plugin-react eslint-plugin-import prettier prettier-eslint
}

function my::install::modules() {
    zshef::util::mng::is_installed "npm" && {
        npm install -g npm $(my::npm::global::modules)
    }
}

function my::update::modules() {
    zshef::util::mng::is_installed "npm" && {
        npm update -g npm $(my::npm::global::modules)
    }
}

function my::install () {
    my::install::asdf
}

function my::config() {
    echo 'export NODE_PATH=`npm root -g`'       > ~/.iypymtiycaa/noderc.sh
    echo 'export PATH="$HOME/.yarn/bin:$PATH"'  > ~/.iypymtiycaa/yarnrc.sh
    echo '{ "extends": "airbnb" }'              > ~/.eslintrc
}
