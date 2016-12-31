#!/bin/bash

. $(dirname $0)/_func.sh

theme='Solarized Dark'

if is_osx; then
  if [ -d ~/.osx-terminal-themes ]; then
    (
    cd ~/.osx-terminal-themes
    git pull
    )
  else
    git clone git@github.com:lysyi3m/osx-terminal-themes.git ~/.osx-terminal-themes
  fi

  #open "$HOME/.osx-terminal-themes/schemes/${theme}.terminal"
fi
