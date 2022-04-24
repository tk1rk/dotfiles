#!/usr/bin/env zsh

#### xdg
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_CONFIG_HOME="$HOME/.config"
[[ -d "$XDG_CONFIG_HOME" ]] || mkdir -p "$XDG_CONFIG_HOME"
### CACHE
export XDG_CACHE_HOME="$HOME/.cache"
[[ -d "$XDG_CACHE_HOME" ]] || mkdir -p "$XDG_CACHE_HOME"
### DATA
export XDG_DATA_DIR="$HOME/.local/share"
[[ -d "$XDG_DATA_DIR" ]] || mkdir -p "$XDG_DATA_DIRS"
### STATE
export XDG_STATE_HOME="$HOME/.local/state"
[[ -d "$XDG_STATE_HOME" ]] || mkdir -p "$XDG_STATE_HOME"
### DOWNLOADS
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
[[ -d "$XDG_DOWNLOAD_DIR" ]] || mkdir -p "$XDG_DOWNLOAD_DIR"
### DOCUMENTS
export XDG_DOCUMENTS_DIR="$HOME/Documents"
[[ -d "$XDG_DOCUMENTS_DIR" ]] || mkdir -p "$XDG_DOCUMENTS_DIR"
### MUSIC
export XDG_MUSIC_DIR="$HOME/Music"
[[ -d "$XDG_MUSIC_DIRS" ]] || mkdir -p "$XDG_MUSIC_DIRS"
### PICTURES
export XDG_PICTURES_DIR="$HOME/Pictures"
[[ -d "$XDG_PICTURES_DIRS" ]] || mkdir -p "$XDG_PICTURES_DIRS"


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
export EDITOR=/usr/bin/nvim
export PAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=4 nomod nolist nonu noma' -\""
export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=4 nomod nolist nonu noma' -\""
export VISUAL=/usr/bin/nvim
export VIMCONFIG="$XDG_CONFIG_HOME/nvim"     

export BROWSER=/usr/bin/vivaldi-stable

# starship config
#export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

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
