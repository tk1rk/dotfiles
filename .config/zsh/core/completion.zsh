#!/usr/bin/env zsh

autoload -Uz compinit
zmodload zsh/complist

# fish like Auto suggestion
autoload -U predict-on
predict-toggle() {
  ((predict_on=1-predict_on)) && predict-on || predict-off
}
zle -N predict-toggle
bindkey '^P' predict-toggle
zstyle ':predict' toggle true
zstyle ':predict' verbose true

## bash completions
source /usr/share/bash-completion

compinit
