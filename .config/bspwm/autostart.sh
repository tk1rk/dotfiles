#!/usr/bin/env sh

# Run polkit daemon if doesn't started.
[ -n "$(pidof xfce-polkit)" ] || /usr/lib/xfce-polkit/xfce-polkit &

# ibus daemon
pgrep ibus-daemon || ibus-daemon &

# nm-applet
pgrep -u $USER -x nm-applet > /dev/null || (nm-applet &)

# Terminate if picom is already running
killall -q picom && while pgrep -u $UID -x picom >/dev/null; do sleep 1; done # Wait until the processes have been shut down
picom --config "${HOME}/.config/picom/picom.conf" &

# xfce4 power manager
xfce4-power-manager &

# dunst
pkill dunst
dunst -conf "${HOME}/.config/dunst/dunstrc" &
	
# window swallowing
pgrep bspswallow || bspswallow &

# Fix cursor.
xsetroot -cursor_name left_ptr

# xsettingsd
xsettingsd &

# Launch keybinding daemon
sxhkd -conf "${HOME}/.config/sxhkd/sxhkdrc" &

# touchpad
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1

# xrdb (themes)
xrdb -override "${HOME}/.Xresources" &

# wallpaper
feh --bg-fill "${HOME}/.config/bspwm/assets/bloodfountain.jpg" &

# Enable Super Keys For Menu
ksuperkey -e 'Super_L=Alt_L|F1' &
ksuperkey -e 'Super_R=Alt_L|F1' &

# Run EWW.
"${HOME}/.local/bin/eww" -c "${HOME}/.config/eww/bar --restart open bar" &

# Fix for eww bar not hiding on a fullscreen window.
"${HOME}/.config/bspwm/bin/eww_fullscreen_fix.sh" &

# Fix windows being below bar
xdo lower -N eww-bar

# alacritty
CONFIG="$HOME/.config/alacritty/alacritty.yml"
if [ "$1" == "-f" ]; then
	alacritty --class 'alacritty-float,alacritty-float' --config-file "$CONFIG"
elif [ "$1" == "-s" ]; then
	alacritty --class 'Fullscreen,Fullscreen' --config-file "$CONFIG" -o window.startup_mode=fullscreen font.size=12
else
	alacritty --config-file "$CONFIG"
fi

                             
# Drop-down terminal (can swap with any app)
bspc rule -a dropdown sticky=on state=floating hidden=on
alacritty --class dropdown -e "zsh -i" &
