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
pgrep -u $USER -x nm-applet > /dev/null || (nm-applet &)

# Terminate if picom is already running
picom -b --config ~/.config/picom/picom.conf --experimental-backends &

# Launch keybinding daemon
pgrep -x sxhkd > /dev/null || sxhkd &

# dunst
dunst -config $HOME/.config/dunst/dunstrc &
	
# Kill if already running
killall -9 ksuperkey

# Enable Super Keys For Menu
ksuperkey -e 'Super_L=Alt_L|F1' &
ksuperkey -e 'Super_R=Alt_L|F1' &

# Set configurations
for i in "$_config"/configs/*.sh; do
	{
		eval "$i" &
	}
done

# Set rules
for i in "$_config"/rules/*.sh; do
	{
		eval "$i" &
	}
done

# Fix cursor.
xsetroot -cursor_name left_ptr &

# touchpad
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1

# xrdb (themes)
xrdb -load $HOME/.Xresources &

# wallpaper
feh --bg-fill "${HOME}/.config/bspwm/wallpapers/bloodfountain.jpg" &

# Run EWW.
eww -c $HOME/.config/eww/bar --restart open bar &

# Fix for eww bar not hiding on a fullscreen window.
$HOME/.config/bspwm/bin/eww_fullscreen_fix.sh &

# Fix windows being below bar
xdo lower -N eww-bar
                          
