#!/usr/bin/env bash


iDIR="$HOME/.config/mako/icons"

# Get Volume
get_volume() {
	volume=`amixer get Master | tail -n1 | awk -F ' ' '{print $5}' | tr -d '[]'`
	echo "$volume"
}

# Get icons
get_icon() {
	vol="$(get_volume)"
	current="${vol%%%}"
	if [[ "$current" -eq "0" ]]; then
		icon="$iDIR/volume-mute.png"
	elif [[ ("$current" -ge "25") && ("$current" -le "25") ]]; then
		icon="$iDIR/volume-low.png"
	elif [[ ("$current" -ge "50") && ("$current" -le "50") ]]; then
		icon="$iDIR/volume-mid.png"
	elif [[ ("$current" -ge "75") && ("$current" -le "75") ]]; then
		icon="$iDIR/volume-high.png"
        elif [[ ("$current" -ge "100") && ("$current" -le "100") ]]; then
		icon="$iDIR/volume-full.png"
	fi
}

# Notify
notify_user() {
	notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$icon" "Volume : $(get_volume)"
}

# Increase Volume
inc_volume() {
	amixer -Mq set Master,0 5%+ unmute && get_icon && notify_user
}

# Decrease Volume
dec_volume() {
	amixer -Mq set Master,0 5%- unmute && get_icon && notify_user
}

# Toggle Mute
toggle_mute() {
	amixer get Master | grep '\[on\]' &>/dev/null
	if [[ "$?" == 0 ]]; then
		amixer set Master toggle && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/volume-mute.png" "Mute"
	else
		amixer set Master toggle && get_icon && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$icon" "Unmute"
	fi
}

# Toggle Mic
toggle_mic() {
	amixer get Capture | grep '\[on\]' &>/dev/null
	if [[ "$?" == 0 ]]; then
		amixer -D pulse sset Capture toggle && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/microphone-mute.png" "Microphone Switched OFF"
	else
		amixer -D pulse sset Capture toggle && get_icon && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/microphone.png" "Microphone Switched ON"
	fi
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	get_volume
elif [[ "$1" == "--inc" ]]; then
	inc_volume
elif [[ "$1" == "--dec" ]]; then
	dec_volume
elif [[ "$1" == "--toggle" ]]; then
	toggle_mute
elif [[ "$1" == "--toggle-mic" ]]; then
	toggle_mic
else
	get_volume
fi
