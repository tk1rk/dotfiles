#!/usr/bin/env sh

# Kill already running process
killall -9 eww mako mpd xfce-polkit rofi clipman wl-clipboard mpd nm-applet blueman-applet pa-applet

# wallpaper
exec=hyprctl hyprpaper wallpaper $HOME/.config/wallpapers/pacman.png

# System
exec-once=systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once=ibus-daemon -drxR
exec-once=/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
exec-once=swaybg -i ~/.config/wallpapers/pacman.png
exec-once=pipewire -c ~/.config/pipewire/pipewire.conf
exec-once=pipewire-pulse 
exec-once=wireplumber 

# Lauch notification daemon (mako)
exec-once=$HOME/.config/hypr/bin/notifications 

# Ksuperkey
exec-once=ksuperkey -e 'Super_L=Alt_L|F1' &
exec-once=ksuperkey -e 'Super_R=Alt_L|F1' &

# Apps
exec-once=xfce4-power-manager --daemon
exec-once=parcellite 
exec-once=greenclip daemon 
exec-once=clipman
exec-once=rofi
exec-once=wl-clipboard
exec-once=wl-clipboard-history -t
exec-once=mpd
exec-once=foot --server 
exec-once=eww daemon 
exec-once=eww open bar 
exec-once=thunar --daemon 
exec-once=nm-applet --indicator
exec-once=blueman --applet


# eww bar
exec-once=eww -c $HOME/.config/eww/bar open bar
exec-once=polybar -q tray -c ~/.config/eww/bar/polybar_tray.ini &
