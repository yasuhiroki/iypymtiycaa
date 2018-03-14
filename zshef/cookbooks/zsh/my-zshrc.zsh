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
alias taketemp='cd "$(mktemp -d)"'

if which python3 > /dev/null; then
  alias serve='python3 -m http.server'
elif which python2 > /dev/null; then
  alias serve='python -m SimpleHTTPServer'
else
  # brew の default python が python3 となったため
  alias serve='python -m http.server'
fi

# Read custom configure
for f in ~/.iypymtiycaa/*
do
    test -f $f || continue
    source $f || echo "Could not source $f"
done
fpath+=(~/.iypymtiycaa/zsh/completions/)
autoload -U compinit
compinit -C

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
