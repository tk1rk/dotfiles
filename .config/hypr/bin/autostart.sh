#!/usr/bin/env sh

exec-once=swaybg -i $HOME/.config/hypr/wallpapers/wallpaper.png
exec-once=eww daemon
exec-once=eww open bar
exec-once=dunst
exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once=killall xdg-desktop-portal xdg-desktop-portal-wlr && /usr/lib/xdg-desktop-portal & /usr/lib/xdg-desktop-portal-wlr

exec-once=hyprpaper
exec-once=waybar
exec-once=xsettingsd
exec-once=hyprctl setcursor Breeze 24
exec-once=swayidle -w before-sleep $locker lock $locker after-resume $locker
exec-once=swaync
exec-once=ibus-daemon -drxR
exec-once=spotifyd
exec-once=/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1



exec-once=xrdb -merge ~/.Xresources &
exec-once=xfce4-power-manager --daemon &
exec-once=xsetroot -cursor_name left_ptr &
exec-once=nitrogen --restore &
exec-once=alttab -i 54x54 -bg "#181f21" -fg "#dadada" -t 50x50 -frame "#8ccf7e" -bc "#67b0e8" -bw 5 -inact "#9bdead" &
exec-once=picom --experimental-backends -b &
exec-once=sxhkd -c ~/.config/worm/sxhkdrc &
exec-once=systemd-inhibit --what=handle-power-key sleep infinity &
exec-once=parcellite &
exec-once=greenclip daemon &
exec-once=eww -c ~/.config/eww/Bar/ open --toggle panel &
exec-once=eww -c ~/.config/l)peww/Indicators/ daemon &
exec-once=eww -c ~/.config/eww/Control-Center/ daemon &
exec-once=/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
once=swaybg -i $NIXOS_CONFIG_DIR/pics/wallpaper.png
exec-once=foot --server
exec-once=wlsunset -l -23 -L -46
exec-once=eww daemon
exec-once=eww open bar
exec-once=dunst


exec-once=hyprpaper 
exec-once=pipewire 
exec-once=pipewire-pulse 
exec-once=wireplumber 
exec-once=swayidle timeout 600 'swaylock' timeout 620 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock' 
exec-once=waybar

exec swayidle -w \
    timeout 300 'swaylock-fancy' \      
    timeout 600 'swaymsg "output * dpms off"' \ 
    resume 'swaymsg "output * dpms on"' 
    before-sleep 'swaylock-fancy'

$
