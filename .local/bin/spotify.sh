#!/usr/bin/env bash 
  
tooltip="$(playerctl -p spotify metadata title) - $(playerctl -p spotify metadata artist)" 
echo "$tooltip"
