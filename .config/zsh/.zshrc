#!/usr/bin/env zsh


# Modules
source "$ZDOTDIR/config/functions.zsh"
source "$ZDOTDIR/config/autosuggestions.zsh"
source "$ZDOTDIR/config/bindkeys.zsh"
source "$ZDOTDIR/config/setopt.zsh"
source "$ZDOTDIR/config/aliases.zsh"
source "$ZDOTDIR/confih/less.zsh"

# FZF - Dracula
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 \ 
                         --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 \
                         --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 \
                         --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'


# neofetch-btw
neofetch

# LS_COLORS (vivid)
export LS_COLORS="$(vivid generate dracula)"

# starship
eval "$(starship init zsh)"
