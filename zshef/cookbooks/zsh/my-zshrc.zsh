### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

alias ls='ls -F --color'

[[ $(uname) =~ "Darwin" ]] && {
  alias ls='ls -GF'
  alias gls='gls -F --color'
}

alias ll='ls -l'
alias la='ls -a'
alias yy='fc -ln -1 | pbcopy'

# Read custom configure
for f in ~/.iypymtiycaa/*
do
    source $f
done

export EDITOR=vim
export PATH="$HOME/mybin:$PATH"

setopt share_history
setopt hist_ignore_dups
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000

stty stop undef
stty start undef

set -o emacs

