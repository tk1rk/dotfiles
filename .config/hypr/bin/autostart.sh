#!/usr/bin/env sh

# System
exec-once=systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK
exec-once=hash dbus-update-activation-environment 2>/dev/null && dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once=ibus-daemon -drxR
exec-once=/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
exec-once=swaybg -i ~/.config/wallpapers/pacman.png
exec-once=pipewire -c ~/.config/pipewire/pipewire.conf
exec-once=pipewire-pulse 
exec-once=wireplumber 

# Apps
exec-once=xfce4-power-manager --daemon
exec-once=parcellite 
exec-once=greenclip daemon 
exec-once=wl-clipboard-history -t

# UI
# Gtk Theme workaround
exec=gsettings set org.gnome.desktop.interface gtk-theme 'Dracula'
exec=gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
exec=gsettings set org.gnome.desktop.interface font-name 'Lemonade 10'
exec=gsettings set org.gnome.desktop.interface cursor-theme 'ArchCursorComplete'

# Idle & Lockscreen
exec=$HOME/.local/bin/lock.sh

# eww bar
exec-once=eww -c $HOME/.config/eww/bar open bar
exec-once=polybar -q tray -c ~/.config/eww/bar/polybar_tray.ini &
