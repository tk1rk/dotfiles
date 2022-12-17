#!/usr/bin/env zsh


# Modules
source "$ZDOTDIR/config/functions.zsh"
source "$ZDOTDIR/config/autosuggestions.zsh"
source "$ZDOTDIR/config/bindkeys.zsh"
source "$ZDOTDIR/config/setopt.zsh"
source "$ZDOTDIR/config/aliases.zsh"
source "$ZDOTDIR/confih/less.zsh"


# startx on login
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  startx >/dev/null 2>&1
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000
#setopt autocd nomatch
setopt autocd nomatch
setopt appendhistory
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/rtkay/.zshrc'

autoload -Uz compinit
fpath+=~/.config
compinit


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




