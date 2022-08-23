#!/usr/bin/env zsh

#### xdg
[[ -d "$XDG_CONFIG_HOME" ]] || mkdir -p "$XDG_CONFIG_HOME"
export XDG_CONFIG_HOME=
[[ -d "$XDG_CACHE_HOME" ]] || mkdir -p "$XDG_CACHE_HOME
export XDG_CACHE_HOME
[[ -d "$XDG_DATA_DIR" ]] || mkdir -p "$XDG_DATA_DIRS"
export XDG_DATA_HOME
[[ -d "$XDG_STATE_HOME" ]] || mkdir -p "$XDG_STATE_HOME"
export XDG_STATE_HOME
[[ -d "$XDG_DOWNLOAD_DIR" ]] || mkdir -p "$XDG_DOWNLOAD_DIR"
export XDG_DOWNLOADS_HOME
[[ -d "$XDG_DOCUMENTS_DIR" ]] || mkdir -p "$XDG_DOCUMENTS_DIR"
export XDG_DOCUMENTS_HOME
[[ -d "$XDG_MUSIC_DIRS" ]] || mkdir -p "$XDG_MUSIC_DIRS"
export XDG_MUSIC_HOME
[[ -d "$XDG_PICTURES_DIRS" ]] || mkdir -p "$XDG_PICTURES_DIRS"
export XDG_PICTURES_HOME

#### ZSH
export ZDOTDIR="$HOME/.config/zsh"
[[ -d "$ZDOTDIR" ]] || mkdir -p "$ZDOTDIR"
### CACHE
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
[[ -d "$CACHEDIR" ]] || mkdir -p "$CACHEDIR"
##s plugins
export ZSH_PLUGINS="$HOME/.config/zsh/plugins"
[[ -d "$ZSH_PLUGINS" ]] || mkdir -p "$ZSH_PLUGINS"
### Completions
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
export TERM="xterm-256color"
export COLORTERM="truecolor"

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
