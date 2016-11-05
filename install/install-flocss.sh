mkdir -p ~/mybin/
if [ ! -f ~/mybin/mkflocss ]; then
  git clone https://gist.github.com/1992d40007e40d50b44501546dd1a4ee.git ~/mybin/mkflocss-repo
  cp ~/mybin/{mkflocss-repo/mkflocss.sh,mkflocss}
  chmod 755 ~/mybin/mkflocss
fi
