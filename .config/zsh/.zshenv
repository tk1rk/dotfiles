#!/usr/bin/env zsh


#### xdg
export XDG_CONFIG_HOME="$HOME/.config"
[[ -d "$XDG_CONFIG_HOME" ]] || mkdir -p "$XDG_CONFIG_HOME"
export XDG_CACHE_HOME="$HOME/.cache"
[[ -d "$XDG_CACHE_HOME" ]] || mkdir -p "$XDG_CACHE_HOME"
export XDG_DATA_HOME="$HOME/.local/share"
[[ -d "$XDG_DATA_DIR" ]] || mkdir -p "$XDG_DATA_DIRS"
export XDG_STATE_HOME="$HOME/.local/state"
[[ -d "$XDG_STATE_HOME" ]] || mkdir -p "$XDG_STATE_HOME"
export XDG_DOWNLOADS_HOME="$HOME/Downloads"
[[ -d "$XDG_DOWNLOAD_DIR" ]] || mkdir -p "$XDG_DOWNLOAD_DIR"
export XDG_DOCUMENTS_HOME="$HOME/Documents"
[[ -d "$XDG_DOCUMENTS_DIR" ]] || mkdir -p "$XDG_DOCUMENTS_DIR"
export XDG_MUSIC_HOME="$HOME/Music"
[[ -d "$XDG_MUSIC_DIRS" ]] || mkdir -p "$XDG_MUSIC_DIRS"
export XDG_PICTURES_HOME="$HOME/Pictures"
[[ -d "$XDG_PICTURES_DIRS" ]] || mkdir -p "$XDG_PICTURES_DIRS"

#### ZSH
export ZDOTDIR="$HOME/.config/zsh"
[[ -d "$ZDOTDIR" ]] || mkdir -p "$ZDOTDIR"
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
[[ -d "$ZSH_CACHE_DIR" ]] || mkdir -p "$ZSH_CACHE_DIR"
export ZSH_PLUGINS="$HOME/.config/zsh/plugins"
[[ -d "$ZSH_PLUGINS" ]] || mkdir -p "$ZSH_PLUGINS"
export ZSH_COMPLETIONS="$HOME/.cache/zsh/completions"
[[ -d "$ZSH_COMPLETIONS" ]] || mkdir -p "$ZSH_COMPLETIONS"

### Create cache and completions dir and add to $fpath ###
fpath=($HOME/.cache/zsh/completions $fpath)
_comp_options+=(globdots)

# Editor + Others
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export VISUAL="nvim"
export PAGER="nvim +Man!"
export MANPAGER="nvim +Man!"     
export BROWSER="vivaldi-stable"

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
