#!/usr/bin/env bash

source "$HOME"/.local/bin/environment.sh

num_updates=$(checkupdates | wc -l)
if [[ $num_updates -gt 0 ]]; then
    notify-send -i "$icon_package" -u normal -r 60 "Available updates" "$num_updates package(s) require updating."
fi
