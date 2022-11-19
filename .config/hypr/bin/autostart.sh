#!/usr/bin/env sh

# System
exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once=killall xdg-desktop-portal xdg-desktop-portal-wlr && /usr/lib/xdg-desktop-portal & /usr/lib/xdg-desktop-portal-wlr
exec-once=xsettingsd
exec-once=ibus-daemon -drxR
exec-once=/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
#exec-once=/usr/lib/mate-polkit/polkit-mate-authentication-agent-1
exec-once=xfce4-power-manager --daemon &
exec-once=dunst -config ~/.config/dunst/dunstrc &
exec-once=pipewire 
exec-once=pipewire-pulse 
exec-once=wireplumber 

# Apps
exec-once=hyprpaper
exec-once=waybar
exec-once=swaync
exec-once=spotifyd
exec-once=swaybg -i ~/.config/hypr/wallpapers/pacman.png
exec-once=sxhkd -c ~/.config/sxhkd/sxhkdrc &
exec-once=parcellite &
exec-once=greenclip daemon &

# UI
exec-once=xrdb -merge ~/.Xresources &
exec-once=xsetroot -cursor_name left_ptr &
exec-once=picom --config ~/.config/picom/picom.conf &
exec-once=eww -c ~/.config/eww/Bar/ open --toggle panel &
exec-once=eww -c ~/.config/eww/Indicators/ daemon &
exec-once=eww -c ~/.config/eww/Control-Center/ daemon &

# Idle & Lockscreen
exec swayidle -w \
    timeout 300 'swaylock-fancy' \      
    timeout 600 'swaymsg "output * dpms off"' \ 
    resume 'swaymsg "output * dpms on"' 
    before-sleep 'swaylock-fancy'

