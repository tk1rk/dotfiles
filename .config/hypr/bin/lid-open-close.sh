#!/usr/bin/env bash 
  
 getHDMI="$(hyprctl monitors | grep -o "HDMI")" 
  
 if [ "$getHDMI" = "HDMI" ]; then 
     hyprctl keyword monitor "eDP-1, disable" 
 else 
     sh ~/.config/hypr/bin/lock.sh 
     hyprctl keyword monitor "eDP-1, 1440x900, 0x0, 1" 
 fi
