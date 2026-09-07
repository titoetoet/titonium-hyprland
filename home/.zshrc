# ==============================================================================
# ~/.zshrc - Modern ZSH Configuration
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. Environment & PATH
# ------------------------------------------------------------------------------
export PATH="$HOME/.local/bin:$HOME/.bin:$PATH"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR="nano"
export TERMINAL="kitty"

# ------------------------------------------------------------------------------
# 2. History Settings
# ------------------------------------------------------------------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY          # Write timestamp in history
setopt SHARE_HISTORY             # Share history across terminals
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded
setopt HIST_IGNORE_ALL_DUPS      # Delete old duplicate entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found
setopt HIST_IGNORE_SPACE         # Do not record lines starting with a space
setopt HIST_SAVE_NO_DUPS         # Do not write duplicate events to history file
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks from each history command

# ------------------------------------------------------------------------------
# 3. Completion System (Zsh Compinit)
# ------------------------------------------------------------------------------
# Add custom completion directory to fpath
fpath=("$HOME/.zsh/completions" $fpath)

autoload -Uz compinit
# Cache completions for faster startup
if [ $(date +'%j') != $(stat -c '%y' "$HOME/.zcompdump" 2>/dev/null | date +'%j' 2>/dev/null) ]; then
  compinit
else
  compinit -C
fi

zmodload -i zsh/complist

# Enable menu-driven auto-completion
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# ------------------------------------------------------------------------------
# 4. Navigation & Directory Options
# ------------------------------------------------------------------------------
setopt AUTO_CD              # Type 'dir' to cd into 'dir'
setopt AUTO_PUSHD           # Push directory to stack
setopt PUSHD_IGNORE_DUPS    # Don't push duplicate directories
setopt PUSHD_SILENT         # Do not print directory stack after pushd/popd

# ------------------------------------------------------------------------------
# 5. Key Bindings
# ------------------------------------------------------------------------------
bindkey -e  # Emacs mode

# Home / End / Delete / Backspace
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line
bindkey '\e[3~' delete-char

# Ctrl+Left / Ctrl+Right (word navigation)
bindkey '\e[1;5C' forward-word
bindkey '\e[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# ------------------------------------------------------------------------------
# 6. Plugins
# ------------------------------------------------------------------------------
# Zsh Autosuggestions
if [ -f "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6c7086,italic"
    # Accept suggestion with Ctrl+Space or Right Arrow
    bindkey '^ ' autosuggest-accept
fi

# Fast Syntax Highlighting
if [ -f "$HOME/.zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ]; then
    source "$HOME/.zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
fi

# Substring History Search (Up / Down arrow search)
if [ -f "$HOME/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh" ]; then
    source "$HOME/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi

# ------------------------------------------------------------------------------
# 7. Useful Aliases
# ------------------------------------------------------------------------------
alias ls='ls --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -lha --color=auto'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -m'
alias cls='clear'

# Git shortcuts
alias g='git'
alias gs='git status -sb'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# Pacman / Yay helpers (Arch Linux)
alias update='sudo pacman -Syu'
alias yupdate='yay -Syu'

# ------------------------------------------------------------------------------
# 8. Initialize Starship Prompt
# ------------------------------------------------------------------------------
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# ------------------------------------------------------------------------------
# 9. Oh My Pi (omp) Shell Completion
# ------------------------------------------------------------------------------
# Handled via autoload in $fpath (~/.zsh/completions/_omp)

# ------------------------------------------------------------------------------
# 10. Yazi & Kitty Integrations
# ------------------------------------------------------------------------------
# Yazi shell wrapper: changes current working directory when exiting yazi
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# Run standalone Yazi and Btop inside Kitty
alias yazi-kitty='kitty --class yazi -e yazi'
alias btop-kitty='kitty --class btop -e btop'

# Run fastfetch on interactive shell startup
if [[ -o interactive ]] && [[ "$TERM" != "dumb" ]] && command -v fastfetch &>/dev/null; then
    fastfetch
fi

# Auto-start Hyprland on TTY1 login
if [ -z "$WAYLAND_DISPLAY" ] && [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec Hyprland
fi

