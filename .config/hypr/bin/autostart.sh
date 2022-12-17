#!/usr/bin/env sh

# System
exec-once=systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK
exec-once=hash dbus-update-activation-environment 2>/dev/null && dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK
exec-once=xsettingsd
exec-once=ibus-daemon -drxR
exec-once=/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
exec-once=xfce4-power-manager --daemon
exec-once=dunst -config ~/.config/dunst/dunstrc 
exec-once=swaybg -i ~/.config/wallpapers/pacman.png
exec-once=pipewire 
exec-once=pipewire-pulse 
exec-once=wireplumber 

# Apps
exec-once=swaybg -i ~/.config/wallpapers/pacman.png
exec-once=sxhkd -c ~/.config/sxhkd/sxhkdrc 
exec-once=parcellite 
exec-once=greenclip daemon 
exec-once=ksuperkey -e 'Super_L=Alt_L|F1' &
exec-once=ksuperkey -e 'Super_R=Alt_L|F1' &

# UI
# Gtk Theme workaround
exec=gsettings set org.gnome.desktop.interface gtk-theme 'Dracula'
exec=gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
exec=gsettings set org.gnome.desktop.interface font-name 'Lemonade 10'
exec=gsettings set org.gnome.desktop.interface cursor-theme 'ArchCursorComplete'

exec-once=xrdb -load ~/.Xresources 
exec-once=xsetroot -cursor_name left_ptr 
exec-once=picom --config ~/.config/picom/picom.conf 
exec-once=eww -c ~/.config/eww/Bar/ open --toggle panel 
exec-once=eww -c ~/.config/eww/Indicators/ daemon 
exec-once=eww -c ~/.config/eww/Control-Center/ daemon 

# Idle & Lockscreen
exec = swayidle -w \
    timeout 300 'swaylock-fancy-rapid 7 3' \      
    timeout 600 'swaymsg "output * dpms off"' \ 
    resume 'swaymsg "output * dpms on"' \
    before-sleep 'swaylock-fancy-rapid 7 3'


