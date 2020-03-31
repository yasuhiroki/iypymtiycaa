export DYLD_LIBRARY_PATH="/usr/local/opt/openssl/lib:$DYLD_LIBRARY_PATH"

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

fpath+=(~/.iypymtiycaa/zsh/completions/)
autoload -U compinit
compinit -C

export EDITOR=vim
export PATH="$HOME/mybin:$PATH"

setopt share_history
setopt hist_ignore_dups
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=10000
export SAVEHIST=100000

stty stop undef
stty start undef

set -o emacs

# Read custom configure
for f in ~/.iypymtiycaa/*
do
    test -f $f || continue
    source $f || echo "Could not source $f"
done

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yasuhiroki/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yasuhiroki/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/yasuhiroki/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yasuhiroki/google-cloud-sdk/completion.zsh.inc'; fi
