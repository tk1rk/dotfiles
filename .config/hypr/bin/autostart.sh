#!/usr/bin/env sh

# Kill already running process
killall -9 eww mako mpd xfce-polkit rofi clipman wl-clipboard mpd nm-applet blueman-applet pa-applet

# wallpaper
exec=hyprctl hyprpaper wallpaper $HOME/.config/wallpapers/pacman.jpeg

# System
exec-once=systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK
exec-once=hash dbus-update-activation-environment 2>/dev/null && dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once=ibus-daemon -drxR
exec-once=/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
exec-once=swaybg -i ~/.config/wallpapers/pacman.png
exec-once=pipewire -c ~/.config/pipewire/pipewire.conf
exec-once=pipewire-pulse 
exec-once=wireplumber 

# Lauch notification daemon (mako)
exec-once=$HOME/.config/hypr/scripts/notifications 

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
