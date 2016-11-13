#!/bin/bsah

mkdir -p ~/mybin/
if [ ! -f ~/mybin/mkflocss ]; then
  curl https://gist.githubusercontent.com/yasuhiroki/1992d40007e40d50b44501546dd1a4ee/raw/dda00dc392d02b1afe6d35c10612fdb13fef7523/mkflocss.sh -o ~/mybin/mkflocss
  chmod 755 ~/mybin/mkflocss
fi
