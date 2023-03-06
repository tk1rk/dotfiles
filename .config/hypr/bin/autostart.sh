#!/usr/bin/env sh

# Load systemd configuration
exec-once = systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = systemctl --user start hyprland-session.target


# Kill already running process
killall -9 eww mako mpd xfce-polkit rofi clipman wl-clipboard mpd nm-applet blueman-applet pa-applet

# wallpaper
exec-once = swaybg -m fill -i ~/.config/hypr/wallpapers/pacman.jpeg

# █▀▀ ▀▄▀ █▀▀ █▀▀
# ██▄ █░█ ██▄ █▄▄
# ██▄ █░█ ██▄ █▄▄
# ██▄ █░█ ██▄ █▄▄
# ██▄ █░█ ██▄ █▄▄
exec-once = ibus-daemon -drxR
exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
exec-once = pipewire -c ~/.config/pipewire/pipewire.conf
exec-once = pipewire-pulse 
exec-once = wireplumber 

# Lauch notification daemon (mako)
exec-once = ~/.config/hypr/bin/notifications 

# Ksuperkey
exec-once = ksuperkey -e 'Super_L=Alt_L|F1' &
exec-once = ksuperkey -e 'Super_R=Alt_L|F1' &

# Apps
exec-once = xfce4-power-manager --daemon
exec-once = parcellite 
exec-once = greenclip daemon 
exec-once = wl-clip-persist --clipboard regular 
exec-once = wl-paste --watch cliphist store 
exec-once = wl-clipboard-history -t
exec-once = mpd
exec-once = nm-applet --indicator
exec-once = blueman --applet
exec-once = ~/.config/hypr/bin/swayidle.sh


# eww bar
exec-once = eww daemon
exec-once = eww -c $HOME/.config/eww/bar open bar
exec-once = polybar -q tray -c ~/.config/eww/bar/polybar_tray.ini &
