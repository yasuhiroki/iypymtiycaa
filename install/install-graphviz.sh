. $(dirname $0)/_func.sh

if is_osx ;then
  brew install graphviz
else
  apt install graphviz
fi

