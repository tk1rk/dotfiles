#!/usr/bin/env zsh

export ZDOTDIR={$ZDOTDIR:-$HOME/.config/zsh}
[[ -f "$ZDOTDIR/.zshrc" ]] && source "$ZDOTDIR/.zshrc"
