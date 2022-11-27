#!/bin/sh

# XDG
XDG_SESSION_TYPE=wayland
XDG_CURRENT_DESKTOP=Hyprland
XDG_SESSION_DESKTOP=Hyprland

# QT
QT_AUTO_SCREEN_SCALE_FACTOR=1
QT_QPA_PLATFORM="wayland;xcb"
QT_WAYLAND_DISABLE_WINDOWDECORATION=1
QT_QPA_PLATFORMTHEME=gtk2

# Toolkit backend variables
_GLX_GSYNC_ALLOWED
export _JAVA_AWT_WM_NONEREPARENTING=1
export SDL_VIDEODRIVER=wayland
export CLUTTER_BACKEND=wayland
export GDK_BACKEND="wayland,x11"

# Theme
export GTK_THEME=Dracula
export XCURSOR_THEME=ArchCursorComplete
export XCURSOR_SIZE=20

exec system-cat --identifier=wayland /usr/bin/Hyprland $@

