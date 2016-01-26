eval "$(rbenv init -)"

alias be='bundle exec'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

source ~/.caddyrc
source ~/.enhancdrc

alias rb='ruby -e'
alias rbn='ruby -nae'
alias rbp='ruby -pae'

alias yy='fc -ln -1 | pbcopy'

export EDITOR=vim

source ~/.rbenvrc
[[ -s "~/.gvm/scripts/gvm" ]] && source "~/.gvm/scripts/gvm"

type pbcopy >/dev/null || alias pbcopy='xsel --clipboard --input'

export NODE_PATH=`npm root -g`

type tmux && alias tmux='tmux -2'
