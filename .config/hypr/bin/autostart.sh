#!/usr/bin/env sh

# System
exec-once=systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK
exec-once=hash dbus-update-activation-environment 2>/dev/null && dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK
exec-once=ibus-daemon -drxR
exec-once=/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
exec-once=xfce4-power-manager --daemon
exec-once=swaybg -i ~/.config/wallpapers/pacman.png
exec-once=pipewire 
exec-once=pipewire-pulse 
exec-once=wireplumber 

# Apps
exec-once=swaybg -i ~/.config/wallpapers/pacman.png
exec-once=parcellite 
exec-once=greenclip daemon 

# UI
# Gtk Theme workaround
exec=gsettings set org.gnome.desktop.interface gtk-theme 'Dracula'
exec=gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
exec=gsettings set org.gnome.desktop.interface font-name 'Lemonade 10'
exec=gsettings set org.gnome.desktop.interface cursor-theme 'ArchCursorComplete'


# Idle & Lockscreen
exec=$HOME/.local/bin/lock.sh

