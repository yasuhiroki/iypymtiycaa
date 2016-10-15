if [ -z "$NVM_DIR" ]; then
  curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
else
  (
  cd "$NVM_DIR"
  git fetch origin
  git checkout master
  git pull
  ) && . "$NVM_DIR/nvm.sh"
fi
