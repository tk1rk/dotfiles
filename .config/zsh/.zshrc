#!/usr/bin/env zsh

# Clone zcomet if necessary
if [[ ! -f ${HOME}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# completion cache path setup 
typeset -g comppath="$HOME/.cache/zsh" 
typeset -g compfile="$comppath/.zcompdump" 

# History in cache directory:
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTFILE=~/.cache/zsh/.zhistory

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# zsh config
for file in $ZDOTDIR/config/*.zsh; 
do
       source "$file"
done


##-----------zcomet------------##
source ${HOME}/.zcomet/bin/zcomet.zsh

zcomet load zsh-users/zsh-syntax-highlighting
zcomet load zsh-users/zsh-autosuggestions
zcomet load romkatv/powerlevel10k


# Run compinit and compile its cache
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
