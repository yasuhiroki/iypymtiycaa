### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

[[ $(uname) =~ "Darwin" ]] && {
  alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
  alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
}

# Read custom configure
[ -s ~/.caddyrc ]   && source ~/.caddyrc
[ -s ~/.enhancdrc ] && source ~/.enhancdrc
[ -s ~/.fzfrc ]     && source ~/.fzfrc
[ -s ~/.rbenvrc ]   && source ~/.rbenvrc
[ -s ~/.myrc/yarnrc ]    && source ~/.myrc/yarnrc
[ -s ~/.gvm/scripts/gvm ] && source ~/.gvm/scripts/gvm

alias rb='ruby -e'
alias rbn='ruby -nae'
alias rbp='ruby -pae'

alias yy='fc -ln -1 | pbcopy'

export EDITOR=vim

type pbcopy >/dev/null || alias pbcopy='xsel --clipboard --input'

export NODE_PATH=`npm root -g`

[ -f "$HOME/.nvm" ] && {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" ]
}

type tmux >/dev/null && alias tmux='tmux -2'

export PATH="$HOME/mybin:$PATH"

stty stop undef
stty start undef

