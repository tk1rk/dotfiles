#!/usr/bin/env zsh

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### ZSH SOURCES ###
typeset -ga sources
for file in "${ZDOTDIR}/core/aliases.zsh" \
            "${ZDOTDIR}/core/bindkeys.zsh" \
            "${ZDOTDIR}/core/completion.zsh" \
            "${ZDOTDIR}/core/functions.zsh" \
            "${ZDOTDIR}/core/less.zsh" \
            "${ZDOTDIR}/core/setopt.zsh" \
    [[ -f "${file}" ]] && source "${file}"
done

=1

# Load plugins.
source $ZDOTDIR/themes/powerlevel10k/powerlevel10k.zsh-theme

# Cargo 
source $HOME/.cargo/env

# install neofetch-btw ###

# LS_COLORS (vivid)
export LS_COLORS="$(vivid generate dracula)"

# p10k
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh 
