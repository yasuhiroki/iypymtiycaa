#!/bin/bash

. $(dirname $0)/_func.sh

if is_osx; then
  is_installed ag || brew install ag
elif is_debian; then
  is_installed ag || sudo apt install silversearcher-ag
else
  exit 1
fi

echo "*~
*.swp

.git
.svn

*.jpeg
*.jpg
*.png
*.gif

*.class
" > ~/.agignore
