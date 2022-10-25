#!/usr/bin/env zsh

# General Setting foldstart
# completion cache path setup 
typeset -g comppath="$HOME/.cache/zsh" 
typeset -g compfile="$comppath/.zcompdump" 

# History in cache directory:
HISTSIZE=10000
SAVEHIST=12000
HISTFILE=~/.cache/zsh/.zhistory

# Basic auto/tab complete:
autoload -U compinit
zmodload zsh/complist
zstyle ':completion:*' menu select
# Include hidden files.
_comp_options+=(globdots)		
# Autocomplete from the middle of the word
zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
compinit
# foldend

# Plugins foldstart
# installed thru pacman, no need to source, might need to run compinitload-plugin "zsh-completions"
load-plugin    "zsh-autosuggestions"
load-plugin    "zsh-autopair"
load-plugin    "zsh-autocomplete"
load-plugin    "zsh-extract"
load-plugin    "fast-syntax-highlighting"
load-plugin    "zsh-history-substring-search"   
load-plugin    "zsh-you-should-use" 
# foldend

compinitload-plugin "zsh-completions"

# Modules foldstart
source "$ZDOTDIR/modules/functions.zsh"
source "$ZDOTDIR/modules/keybinds.zsh"
source "$ZDOTDIR/modules/setopt.zsh"
source "$ZDOTDIR/modules/alias.zsh"
source "$ZDOTDIR/modules/less.zsh"
# foldend

# Some quick plugin settings
ZSH_HIGHLIGHT_MAXLENGTH=100  
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#85858f,bold,underline"
# foldend

# Cargo 
source $HOME/.cargo/env

# neofetch-btw
neofetch

# LS_COLORS (vivid)
export LS_COLORS="$(vivid generate dracula)"

# p10k
source /usr/share/powerlevel10k/powerlevel10k.zsh-theme

vim:foldmarker=foldstart,foldend
