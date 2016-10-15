# My node development
#  - Install manager: nvm
#  - Package manager: npm/yarn

. $(dirname $0)/_func.sh

# Install NVM
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


yarnrc=".yarnrc"
if is_osx ;then
  brew install yarn
else
  curl -o- -L https://yarnpkg.com/install.sh | bash
fi
touch ~/${yarnrc}
grep -sq 'export PATH' ~/${yarnrc} || echo 'export PATH="$HOME/.yarn/bin:$PATH"' >> ~/${yarnrc}
