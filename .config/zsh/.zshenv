#!/usr/bin/env zsh

#### xdg
export XDG_CONFIG_HOME="$HOME/.config/"
[[ -d "$XDG_CONFIG_HOME" ]] || mkdir -p "$XDG_CONFIG_HOME"
### Data
export XDG_DATA_DIRS="$HOME/.local/share/:/usr/share/"
[[ -d "$XDG_DATA_DIRS" ]] || mkdir -p "$XDG_DATA_DIRS"
### Cache
export XDG_CACHE_HOME="$HOME/.cache/"
[[ -d "$XDG_CACHE_HOME" ]] || mkdir -p "$XDG_CACHE_HOME"
###
mkdir -p {
    $XDG_CONFIG_HOME,$XDG_DATA_HOME,$XDG_CACHE_HOME
}

#### zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh/"
[[ -d "$ZDOTDIR" ]] || mkdir -p "$ZDOTDIR"
### Custom
export ZSH_CUSTOM="$ZDOTDIR/custom/"
[[ -d "$ZSH_CUSTOM" ]] || mkdir -p "$ZSH_CUSTOM"
### Cache
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh/"
[[ -d "$CACHEDIR" ]] || mkdir -p "$CACHEDIR"
##s plugins
export ZSH_PLUGINS="$ZDOTDIR/plugins/"
[[ -d "$ZSH_PLUGINS" ]] || mkdir -p "$ZSH_PLUGINS"
### Completions
export ZSH_COMPLETIONS="$ZSH_CACHE_DIR/completions/"
[[ -d "$ZSH_COMPLETIONS" ]] || mkdir -p "$ZSH_COMPLETIONS"
###
mkdir -p {
    $ZDOTDIR,$ZSH_CACHE_DIR,$ZSH_PLUGINS,$ZSH_CUSTOM,$ZSH_COMPLETIONS
}

### Create cache and completions dir and add to $fpath ###
mkdir -p "$ZSH_CACHE_DIR/completions"
(( ${fpath[(Ie)"$ZSH_CACHE_DIR/completions"]} )) || fpath=("$ZSH_CACHE_DIR/completions" $fpath)

### function path ###
fpath=($ZSH/functions $ZSH/completions $fpath)
_comp_options+=(globdots)

### Add all defined plugins to fpath. This must be done ###
### before running compinit. ###
for plugin ($plugins); do
  if is_plugin $ZSH_CUSTOM $plugin; then
    fpath=($ZSH_CUSTOM/plugins/$plugin $fpath)
  elif is_plugin $ZSH $plugin; then
    fpath=($ZSH/plugins/$plugin $fpath)
  fi
done

# install bat-cat-git 
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# starship config
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# home
export HOME="/home/tk"                     

# editor                                    
export EDITOR="nvim"                          
export VISUAL="nvim"
export VIMCONFIG="$XDG_CONFIG_HOME/nvim"     

### Path ###
export PATH="/usr/bin:/bin:/usr/sbin:$HOME/.local/sbin:/sbin:$HOME/.local/bin:$HOME/.local/share:$HOME/.cargo/bin:$HOME/.cargo/env:$PATH"

### TERMINAL ###
export TERM="xterm-256color"
export COLORTERM="truecolor"

### LANG ###
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

### enhancd ###
export ENHANCD_FILTER="fzf:fzy:peco"

# Less/Pager
export PAGER="less -R"
export WORDCHARS='~!#$%^&*(){}[]<>?.+;'  # sane moving between words on the prompt
export GPG_TTY='$(tty)'
