#!/usr/bin/env sh

theme="launchpad"
dir="$HOME/.config/rofi/themes"

rofi -no-lazy-grab -show drun -modi drun -theme $dir/"$theme"

