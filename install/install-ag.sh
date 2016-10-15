. $(dirname $0)/_func.sh

if is_osx ;then
  brew install ag
elif is_debian; then
  apt install silversearcher-ag
else
  exit 0
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
