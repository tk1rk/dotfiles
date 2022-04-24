#!/usr/bin/env sh

# options to be displayed
option0="screen"
option1="area"
option2="window"

# options to be displyed
options="$option0\n$option1\n$option2"

selected="$(echo -e "$options" | rofi -lines 3 -dmenu -p "scrot")"
case $selected in
    $option0)
        cd $XDG_PICTURES_DIR && sleep 1 && scrot;;
    $option1)
        cd $XDG_PICTURES_DIR && scrot -s;;
    $option2)
        cd $XDG_PICTURES_DIR && sleep 1 && scrot -u;;
esac
