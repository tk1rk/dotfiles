#!/usr/bin/env sh

# Run polkit daemon if doesn't started.
[ -n "$(pidof xfce-polkit)" ] || /usr/lib/xfce-polkit/xfce-polkit &

# xfce4 power manager
xfce4-power-manager &

# ibus daemon
pgrep ibus-daemon || ibus-daemon &

# java
wmname LG3D &

# nm-applet
pkill nm-applet
pgrep -u $USER -x nm-applet > /dev/null || (nm-applet &)

# Terminate if picom is already running
killall -q picom && while pgrep -u $UID -x picom >/dev/null; do sleep 1; done # Wait until the processes have been shut down
picom --config $HOME/.config/picom/picom.conf &

# Launch keybinding daemon
pkill sxhkd
sxhkd --config $HOME/.config/sxhkd/sxhkdrc &

# dunst
pkill dunst
dunst -config $HOME/.config/dunst/dunstrc &
	
# Enable Super Keys For Menu
ksuperkey -e 'Super_L=Alt_L|F1' &
ksuperkey -e 'Super_R=Alt_L|F1' &

# window swallowing
pgrep bspswallow || bspswallow &

# Fix cursor.
xsetroot -cursor_name left_ptr

# xsettingsd
xsettingsd &

# touchpad
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1

# xrdb (themes)
xrdb $HOME/.Xresources &

# wallpaper
feh --bg-fill "${HOME}/.config/bspwm/wallpapera/bloodfountain.jpg" &

# Run EWW.
eww -c $HOME/.config/eww/bar --restart open bar &

# Fix for eww bar not hiding on a fullscreen window.
$HOME/.config/bspwm/bin/eww_fullscreen_fix.sh &

# Fix windows being below bar
xdo lower -N eww-bar

# alacritty
CONFIG=$HOME/.config/alacritty/alacritty.yml
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
