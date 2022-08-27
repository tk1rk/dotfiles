#!/usr/bin/env zsh

ZDOTDIR=$HOME/.config/zsh
export ZDOTDIR

[[ -f "$ZDOTDIR/.zshenv" ]] || source "$ZDOTDIR/.zshenv"
