#!/usr/bin/env bash
if [[ "$1" == "force" || ! $(mediaactive.sh) ]]; thenq
	playerctl -a pause
	hyprctl keyword monitor eDP-1,preferred,10000x10000,1 
	systemctl suspend-then-hibernate
else
	lockscreen.sh
fi
