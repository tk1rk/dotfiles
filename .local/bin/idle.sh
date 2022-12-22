#!/usr/bin/env bash
if grep -q open /proc/acpi/button/lid/LID0/state; then
	hyprctl keyword monitor eDP-1,preferred,autoxa,1
else
	if [[ "$(monitor.sh count)" == "1" ]]; then
		suspend.sh force
	else
		hyprctl keyword monitor eDP-1,disable
	fi
fi
