#!/bin/bash

. $(dirname $0)/_func.sh

install_caddy_dir=".golf-caddy"

if [ -d ~/${install_caddy_dir} ]; then
    (
    cd ~/${install_caddy_dir}
    git pull
    )
else
    git clone git@github.com:shinh/caddy.git ~/${install_caddy_dir}
fi

update_rc $(dirname $0)/rc/caddyrc.sh
