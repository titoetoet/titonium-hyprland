fpath+=("$HOME/.zsh/pure")

autoload -U promptinit; promptinit
prompt pure

autoload -U colors && colors
export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"


HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory     
setopt hist_ignore_all_dups


bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

fastfetch
export PATH="$HOME/.bun/bin:$PATH"
