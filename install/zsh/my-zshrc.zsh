### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

[[ $(uname) =~ "Darwin" ]] && {
  alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
  alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
}

# Read custom configure
source ~/.iypymtiycaa/*
[ -s ~/.gvm/scripts/gvm ] && source ~/.gvm/scripts/gvm

alias yy='fc -ln -1 | pbcopy'

export EDITOR=vim

type pbcopy >/dev/null || alias pbcopy='xsel --clipboard --input'

type tmux >/dev/null && alias tmux='tmux -2'

export PATH="$HOME/mybin:$PATH"

stty stop undef
stty start undef

