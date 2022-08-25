#!/usr/bin/env zsh

# zcomet
if [[ ! -e ~/.zcomet/bin ]]; then
  git clone --depth=1 https://github.com/agkozak/zcomet.git ~/.zcomet/bin
fi

source ~/.zcomet/bin/zcomet.zsh

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# completion cache path setup 
 typeset -g comppath="$HOME/.cache/zsh" 
 typeset -g compfile="$comppath/.zcompdump" 
 
# source 
files="$HOME/.config/.zsh/plugins/*.zsh"
 
for f in $files
do
        source $ZDOTDIR/plugins/"$@"
done
 

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor regexp root line)
ZSH_HIGHLIGHT_MAXLENGTH=512

zcomet load zsh-users/zsh-syntax-highlighting
zcomet load zsh-users/zsh-autosuggestions
zcomet load romkatv/powerlevel10k

zcomet compinit


# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# History in cache directory:
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTFILE=~/.cache/zsh/.zhistory

source ~/.zcomet/bin/zcomet.zsh

ZSH_AUTOSUGGEST_MANUAL_REBIND=1

zcomet load zsh-users/zsh-syntax-highlighting
zcomet load zsh-users/zsh-autosuggestions
zcomet load romkatv/powerlevel10k

zcomet compinit
# sheldon
eval "$(sheldon source)"

# Cargo 
source $HOME/.cargo/env

# neofetch-btw
neofetch

# LS_COLORS (vivid)
export LS_COLORS="$(vivid generate dracula)"

# p10k
source /usr/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh" 
