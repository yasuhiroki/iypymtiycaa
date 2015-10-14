#!/bin/bsah

install_caddy_dir=".golf-caddy"

if [ -d ~/${install_caddy_dir} ]; then
    (
    cd ~/${install_caddy_dir}
    git pull
    )
else
    git clone git@github.com:shinh/caddy.git ~/${install_caddy_dir}
fi

caddyrc=".caddyrc"
grep -sq 'alias' ~/${caddyrc} || echo "alias caddy=\"ruby ${install_caddy_dir}/caddy.rb\"" > ~/${caddyrc}
grep -sq "${caddyrc}" ~/.bashrc || echo "source ~/${caddyrc}" >> ~/.bashrc

