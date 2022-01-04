export LC_TIME="C"
export LANG="ja_JP.UTF-8"

export DYLD_LIBRARY_PATH="/usr/local/opt/openssl/lib:$DYLD_LIBRARY_PATH"

fpath+=(~/.iypymtiycaa/zsh/completions/)
autoload bashcompinit && bashcompinit
autoload -U compinit && compinit -C

export EDITOR=vim

setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=10000
export SAVEHIST=100000

typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'

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
