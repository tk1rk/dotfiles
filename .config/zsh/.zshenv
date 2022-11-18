#!/usr/bin/env zsh


#### xdg
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DOWNLOADS_HOME="$HOME/Downloads"
export XDG_DOCUMENTS_HOME="$HOME/Documents"
export XDG_MUSIC_HOME="$HOME/Music"
export XDG_PICTURES_HOME="$HOME/Pictures"

#### ZSH
export ZDOTDIR="$HOME/.config/zsh"
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
export ZSH_PLUGINS="$HOME/.config/zsh/plugins"
export ZSH_COMPLETIONS="$HOME/.cache/zsh/completions"

### Create cache and completions dir and add to $fpath ###
fpath=($HOME/.cache/zsh/completions $fpath)
_comp_options+=(globdots)

# Editor + Others
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export VISUAL="nvim"
export PAGER="nvim +Man!"
export MANPAGER="nvim +Man!"     
export BROWSER="vivaldiH"

# Man pages color support
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# sxhkd uses $SHELL by default (zsh)
set -U SXHKD_SHELL sh

### Path ###
export PATH="$HOME/.local/bin:$HOME/.local/share:$HOME/.cargo/bin:$HOME/.cargo/env:$HOME/Applications:$HOME/.config/rofi/bin:HOME/.config/polybar/themes/pwidgets/scripts:$PATH"

### TERMINAL ###
export TERMINAL="xterm-kitty"
export COLORTERM="truecolor"
export CLICOLOR=1

### LANG ###
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# misc
export WORDCHARS='~!#$%^&*(){}[]<>?.+;'  
export GPG_TTY="$(tty)"

# ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.rgrc"

# bat
export BAT_THEME="Dracula"

# LS_COLORS
export LS_COLORS="$(vivid generate dracula)"
