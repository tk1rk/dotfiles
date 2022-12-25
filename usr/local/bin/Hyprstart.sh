#!/bin/sh

# XDG
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=Hyprland

# QT
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_QPA_PLATFORM="wayland;xcb"
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_QPA_PLATFORMTHEME=qt5ct

# Toolkit backend variables
_GLX_GSYNC_ALLOWED
export _JAVA_AWT_WM_NONEREPARENTING=1
export SDL_VIDEODRIVER=wayland
export CLUTTER_BACKEND=wayland
export GDK_BACKEND="wayland;x11"

# Theme
export GTK_THEME=Dracula
export XCURSOR_THEME=ArchCursorComplete
export XCURSOR_SIZE=32

exec system-cat --identifier=wayland /usr/bin/Hyprland $@

