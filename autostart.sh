

exec xrdb -merge ~/.Xresources &
exec xfce4-power-manager --daemon &
exec xsetroot -cursor_name left_ptr &
exec nitrogen --restore &
exec alttab -i 54x54 -bg "#181f21" -fg "#dadada" -t 50x50 -frame "#8ccf7e" -bc "#67b0e8" -bw 5 -inact "#9bdead" &
exec picom --experimental-backends -b &
exec sxhkd -c ~/.config/worm/sxhkdrc &
exec systemd-inhibit --what=handle-power-key sleep infinity &
exec parcellite &
exec greenclip daemon &
exec eww -c ~/.config/eww/Bar/ open --toggle panel &
exec eww -c ~/.config/eww/Indicators/ daemon &
exec eww -c ~/.config/eww/Control-Center/ daemon &
exec /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &


exec-once=hyprpaper 
 exec-once=pipewire 
 exec-once=pipewire-pulse 
 exec-once=wireplumber 
 exec=swayidle timeout 600 'swaylock' timeout 620 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock' 
 exec-once=waybar

$wallpaper=~/Pictures/Wallpapers/z-w-gu-canal.jpg
$term=kitty
$floating_term=alacritty

$wallpaper=~/Pictures/Wallpapers/z-w-gu-canal.jpg
$term=kitty
$floating_term=alacritty
$editor=code
$notetaker=logseq
$chat=slack
$mailer=mailspring
$music=~/bin/qobuz
$browser=MOZ_ENABLE_WAYLAND=1 firefox
$filemanager=thunar
$passwordmanager=~/bin/Buttercup-linux-x64.AppImage
$calendar=~/bin/calendar
# set $calendar flatpak run com.microsoft.Teams
$videcon=XDG_SESSION_TYPE=x11 XDG_CURRENT_DESKTOP=gnome flatpak run us.zoom.Zoom
$locker=swaylock -f -e -l -L -s fill -i $wallpaper
$suspend_and_lock=swaylock -f -e -l -L -s fill -i $wallpaper && sleep 2 && 