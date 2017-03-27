### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

alias ls='ls -F --color'

[[ $(uname) =~ "Darwin" ]] && {
  alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
  alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

  alias ls='ls -GF'
  alias gls='gls -F --color'
}

# Read custom configure
for f in ~/.iypymtiycaa/*
do
    source $f
done

alias yy='fc -ln -1 | pbcopy'

export EDITOR=vim

type pbcopy >/dev/null || alias pbcopy='xsel --clipboard --input'

type tmux >/dev/null && alias tmux='tmux -2'

export PATH="$HOME/mybin:$PATH"

setopt share_history
setopt hist_ignore_dups
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000

stty stop undef
stty start undef

set -o emacs

