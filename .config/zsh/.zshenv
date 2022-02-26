#!/usr/bin/env zsh

#### xdg
export XDG_CONFIG_HOME="$HOME/.config"
[[ -d "$XDG_CONFIG_HOME" ]] || mkdir -p "$XDG_CONFIG_HOME"
### Data
export XDG_DATA_DIRS="$HOME/.local/share"
[[ -d "$XDG_DATA_DIRS" ]] || mkdir -p "$XDG_DATA_DIRS"
### Cache
export XDG_CACHE_HOME="$HOME/.cache"
[[ -d "$XDG_CACHE_HOME" ]] || mkdir -p "$XDG_CACHE_HOME"

#### zsh
export ZDOTDIR="$HOME/.config/zsh"
[[ -d "$ZDOTDIR" ]] || mkdir -p "$ZDOTDIR"
### Cache
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
[[ -d "$CACHEDIR" ]] || mkdir -p "$CACHEDIR"
##s plugins
export ZSH_PLUGINS="$HOME/.config/zsh/plugins"
[[ -d "$ZSH_PLUGINS" ]] || mkdir -p "$ZSH_PLUGINS"
### Completions
export ZSH_COMPLETIONS="$HOME/.cache/zsh/completions"
[[ -d "$ZSH_COMPLETIONS" ]] || mkdir -p "$ZSH_COMPLETIONS"

### Create cache and completions dir and add to $fpath ###
fpath=("$HOME/.cache/zsh/completions" $fpath)
_comp_options+=(globdots)

### Add all defined plugins to fpath. This must be done ###
### before running compinit. ###
for plugin ($plugins); do
  if is_plugin $ZSH_PLUGINS $plugin; then
    fpath=($ZSH_PLUGINS/$plugin $fpath)
  elif is_plugin $ZSH_PLUGINS $plugin; then
    fpath=($ZSH_PLUGINS/plugins/$plugin $fpath)
  fi
done

# install bat-cat-git 
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# starship config
#export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# editor                                    
export EDITOR="nano"                          
export VISUAL="nano"
export VIMCONFIG="$XDG_CONFIG_HOME/nvim"     

### Path ###
export PATH="/usr/bin:/bin:/usr/sbin:$HOME/.local/sbin:/sbin:$HOME/.local/bin:$HOME/.local/share:$HOME/.cargo/bin:$HOME/.cargo/env:$PATH"

### TERMINAL ###
export TERM="xterm-256color"
export COLORTERM="truecolor"
DISABLE_LS_COLORS="true"

### LANG ###
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# Less/Pager
export PAGER="less -R"
export WORDCHARS='~!#$%^&*(){}[]<>?.+;'  
export GPG_TTY="$(tty)"

# ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# bat
export BAT_THEME="Dracula"

# p10k
source "$ZDOTDIR/themes/powerlevel10k/powerlevel10k.plugin.zsh"
