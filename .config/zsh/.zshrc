#!/usr/bin/env zsh

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zsh-znap
if [[ ! -z $HOME/.zsh-snap ]]; then
    command git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git $HOME/.zsh-znap.zsh && \
    command echo "# znap \nsource "$HOME/.zsh-snap/install.zsh""
fi

# completion cache path setup 
 typeset -g comppath="$HOME/.cache/zsh" 
 typeset -g compfile="$comppath/.zcompdump" 
  
 if [[ -d "$comppath" ]]; then 
         [[ -w "$compfile" ]] || rm -rf "$compfile" >/dev/null 2>&1 
 else 
         mkdir -p "$comppath" 
 fi


ZSH_AUTOSUGGEST_USE_ASYNC="true"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(expand-or-complete bracketed-paste accept-line push-line-or-edit)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=$color8,bold"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor regexp root line)
ZSH_HIGHLIGHT_MAXLENGTH=512


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


source $ZDOTDIR/.znap.zsh

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

[[ ! -f "${HOME}/.p10k.zsh" ]] || source "${HOME}/.p10k.zsh" 
