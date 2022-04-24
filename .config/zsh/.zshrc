#!/usr/bin/env zsh

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZSH SOURCES 
typeset -ga sources
for file in "${ZDOTDIR}/core/aliases.zsh" \
            "${ZDOTDIR}/core/bindkeys.zsh" \
            "${ZDOTDIR}/core/completion.zsh" \
            "${ZDOTDIR}/core/functions.zsh" \
            "${ZDOTDIR}/core/less.zsh" \
            "${ZDOTDIR}/core/setopt.zsh" \
    [[ -f "${file}" ]] && source "${file}"
done

# ZI
__ZI="${ZHOME}/.zi/bin/zi.zsh"

if [[ ! -f "$__ZI" ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing ZI Initiative Plugin Manager (z-shell/zi)…%f"
  command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
  command git clone https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

. "$__ZI"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# p10k
zt light-mode for \
pick'async.zsh' \
  mafredri/zsh-async \
  romkatv/powerlevel10k 

# These plugins provide many aliases - atload''
zi wait lucid for \
  OMZ::lib/git.zsh \
atload"unalias grv" \
  OMZ::plugins/git/git.plugin.zsh

# Load a few important annexes, without Turbo.
zi light-mode compile'*handler' for \
z-shell/z-a-patch-dl \
z-shell/z-a-readurl \
z-shell/z-a-bin-gem-node \
z-shell/z-a-submods
zi light z-shell/declare-zsh

# ZI plugins
# ZUI - Semi-graphical .zshrc editor for zi commands
zi load z-shell/zui
zi ice lucid wait'[[ -n ${ZLAST_COMMANDS[(r)cras*]} ]]'
zi load z-shell/zi-crasis

# history
zt atinit'HISTFILE="${HOME}/.cache/zsh/.zhistory"' for \
  OMZL::history.zsh

# Don't bind these keys until ready
bindkey -r '^[[A'
bindkey -r '^[[B'
function __bind_history_keys() {
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
}
# History substring searching
zi ice wait lucid atload'__bind_history_keys'
zi light zsh-users/zsh-history-substring-search

# autosuggestions, trigger precmd hook upon load
zi ice wait lucid atload'_zsh_autosuggest_start'
zi light zsh-users/zsh-autosuggestions
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=10
 
# zsh-completions
zi ice wait blockf lucid atpull'zi creinstall -q .'
zi load zsh-users/zsh-completions

# Syntax highlighting
zi ice wait lucid atinit'zicompinit; zicdreplay'
zi light z-shell/F-Sy-H

# Cargo 
source $HOME/.cargo/env

# neofetch-btw
neofetch

# LS_COLORS (vivid)
export LS_COLORS="$(vivid generate dracula)"

# p10k
source $ZDOTDIR/themes/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh 
