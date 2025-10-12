#!/usr/bin/env zsh
# Example .zshrc configuration with ZPM
# Copy this to ~/.zshrc or integrate parts into your existing config

#============================================================
# ZPM Configuration
#============================================================

# (Optional) Configure ZPM before sourcing
# export ZPM_DIR="$HOME/.local/share/zpm"  # Custom directory
# export ZPM_MAX_JOBS=20                   # More parallel jobs
# export ZPM_VERBOSE=1                     # Verbose output

# Source ZPM (adjust path as needed)
source "${HOME}/.zpm.zsh"

#============================================================
# Plugin Installation
#============================================================

# Uncomment to install plugins (run once, then comment out)
# This is optional - you can also run these commands manually

# zpm install \
#   zsh-users/zsh-autosuggestions \
#   zdharma-continuum/fast-syntax-highlighting \
#   zsh-users/zsh-completions \
#   romkatv/powerlevel10k \
#   agkozak/zsh-z \
#   zsh-users/zsh-history-substring-search

#============================================================
# Essential Plugins - Load Immediately
#============================================================

# Theme (load first for prompt)
zpm load powerlevel10k 2>/dev/null || true

# Syntax highlighting (load near end for performance)
zpm load fast-syntax-highlighting 2>/dev/null || true

# Auto-suggestions
zpm load zsh-autosuggestions 2>/dev/null || true

# Better completions
zpm load zsh-completions 2>/dev/null || true

# Directory jumping
zpm load zsh-z 2>/dev/null || true

# History substring search
zpm load zsh-history-substring-search 2>/dev/null || true

#============================================================
# Lazy-Loaded Plugins (for better startup performance)
#============================================================

# Load NVM only when node/npm/nvm is first used
# zpm_lazy_load nvm nvm node npm npx

# Load rbenv only when ruby/gem/rbenv is first used
# zpm_lazy_load rbenv rbenv ruby gem bundle

# Load pyenv only when python/pip/pyenv is first used
# zpm_lazy_load pyenv pyenv python pip

#============================================================
# ZSH Configuration
#============================================================

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

# Directory navigation
setopt AUTO_CD              # cd by typing directory name
setopt AUTO_PUSHD           # Push directories onto stack
setopt PUSHD_IGNORE_DUPS    # Don't push duplicates
setopt PUSHD_SILENT         # Don't print directory stack

# Completion
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' verbose yes

# Better completion for kill command
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#============================================================
# Key Bindings
#============================================================

# Use emacs key bindings (or use 'bindkey -v' for vi mode)
bindkey -e

# History search with up/down arrows
if [[ -n "${ZPM_PLUGINS[zsh-history-substring-search]}" ]]; then
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
    bindkey -M emacs '^P' history-substring-search-up
    bindkey -M emacs '^N' history-substring-search-down
fi

# Ctrl+left/right for word navigation
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Delete key
bindkey '^[[3~' delete-char

#============================================================
# Aliases
#============================================================

# ZPM shortcuts
alias zpm-update='zpm update'
alias zpm-list='zpm list'
alias zpm-clean='zpm clean'

# Common aliases
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'

# Safety aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Editor
export EDITOR='vim'
export VISUAL='vim'

#============================================================
# Additional Configuration
#============================================================

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Colorful ls
if command -v dircolors &>/dev/null; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
elif [[ "$OSTYPE" == darwin* ]]; then
    export CLICOLOR=1
    export LSCOLORS=ExFxBxDxCxegedabagacad
fi

# Colorful grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#============================================================
# Functions
#============================================================

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract various archive formats
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"    ;;
            *.tar.gz)    tar xzf "$1"    ;;
            *.bz2)       bunzip2 "$1"    ;;
            *.rar)       unrar x "$1"    ;;
            *.gz)        gunzip "$1"     ;;
            *.tar)       tar xf "$1"     ;;
            *.tbz2)      tar xjf "$1"    ;;
            *.tgz)       tar xzf "$1"    ;;
            *.zip)       unzip "$1"      ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1"       ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Quick file search
ff() {
    find . -type f -name "*$1*"
}

# Quick directory search
fd() {
    find . -type d -name "*$1*"
}

#============================================================
# Plugin-specific Configuration
#============================================================

# zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1

# fast-syntax-highlighting
FAST_HIGHLIGHT[chroma-man]=

#============================================================
# Powerlevel10k Instant Prompt
#============================================================

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#============================================================
# Final Setup
#============================================================

# Print ZPM status on shell start (optional, comment out if too verbose)
# echo ""
# zpm status
# echo ""

# Welcome message
echo "🚀 Shell loaded with ZPM - Type 'zpm help' for commands"
