#!/usr/bin/env zsh

typeset -A ZI
ZI[HOME_DIR]="$HOME.config/zi" 
ZI[BIN_DIR]="$HOME/.config/zi/bin"
if [[ ! -f "${ZI[BIN_DIR]}/zi.zsh" ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.config/zi" && command chmod g-rwX "$HOME/.config/zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.config/zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.config/zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi


# auto-exa
[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor
auto-exa () { exa ${exa_params}; }
[[ ${chpwd_functions[(r)auto-exa]} == auto-exa ]] || chpwd_functions=( auto-exa $chpwd_functions )

# Modules
source "$ZDOTDIR/config/functions.zsh"
source "$ZDOTDIR/config/autosuggestions.zsh"
source "$ZDOTDIR/config/bindkeys.zsh"
source "$ZDOTDIR/config/setopt.zsh"
source "$ZDOTDIR/config/aliases.zsh"
source "$ZDOTDIR/confih/less.zsh"





# Coloured output
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    command man "$@"
}

cd() {
    builtin cd "$@" && exa -la --header --icons --color=always --color-scale --no-time --group-directories-first
}

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh




