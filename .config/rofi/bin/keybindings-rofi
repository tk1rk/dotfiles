#!/usr/bin/env sh

awk '/^[a-z]/ && last {print "<small>",$0,"\t",last,"</small>"} {last=""} /^#/{last=$0}' ~/.config/sxhkd/sxhkdrc |
    column -t -s $'\t' |
    rofi -dmenu -i -p "keybindings:" -markup-rows -no-show-icons -columns 1 -width 1000 -lines 15 -yoffset 40
