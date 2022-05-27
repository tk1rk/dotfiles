#!/usr/bin/env sh

# polkit client
#pgrep lxpolkit || lxpolkit &
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# ibus daemon
pgrep ibus-daemon || ibus-daemon &

# nm-applet
pgrep -u $USER -x nm-applet > /dev/null || (nm-applet &)

# picom
while pgrep -u $UID -x picom > /dev/null; do sleep 1; done
picom -config "$HOME/.config/picom/picom.conf" &	

# xfce4 power manager
xfce4-power-manager &

# dunst
pkill dunst
dunst -conf "$HOME/.config/dunst/dunstrc" &
	
# window swallowing
pgrep bspswallow || bspswallow &

# xsettingsd
xsettingsd &

# Launch keybinding daemon
sxhkd -conf "$HOME/.config/sxhkd/sxhkdrc" &

# touchpad
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1

# xrdb (themes)
xrdb merge "$HOME/.Xresources" &

# wallpaper
feh --bg-fill "$HOME/.config/bspwm/wallpapers/arch.png" &

# pulseaudio
pulseaudio &

# light-locker
#pgrep light-locker || light-locker &

# polybar
pkill polybar
polybar -c "$HOME/.config/polybar/launch.sh" --pwidgets & 

# polybar autohide
polybar-msg cmd hide | bspc config top_padding 0
polybar-msg cmd show | bspc config top_padding <gaps>

# Run EWW.
eww -c "$HOME/.config/eww/bar" --restart open bar &

# eww_bar - close while fullscreen
bspc subscribe node_state | while read -r _ _ _ _ state flag; do
    if [ "$state" != "fullscreen" ]; then
        continue
    fi
    if [ "$flag" == on ]; then
        "$HOME/.local/bin/eww" -c "$HOME/.config/eww/bar" close-all
  else
        "$HOME/.local/bin/eww" -c "$HOME/.config/eww/bar" open bar
    fi
done &
                             
# Drop-down terminal (can swap with any app)
bspc rule -a dropdown sticky=on state=floating hidden=on
alacritty --class dropdown -e "zsh -i" &
