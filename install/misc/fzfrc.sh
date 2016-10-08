[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias fzf="fzf --reverse"
export FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS//--reverse/} --reverse"

