#!/usr/bin/env sh 
  
current_theme="$(cat "$HOME"/.config/.current_theme)" 
  
if [ "$current_theme" = "dracula" ]; then 
  
     icon_memory="$HOME/.local/bin/notifications/icons/Dracula/memory.png" 
     icon_bell="$HOME/.local/bin/notifications/icons/Dracula/bell-notification.png" 
     icon_alert="$HOME/.local/bin/notifications/icons/Dracula/alert.png" 
     icon_succes="$HOME/.local/bin/notifications/icons/Dracula/succes.png" 
     icon_screenshot="$HOME/.local/bin/notifications/icons/Dracula/screenshot.png" 
     icon_usb_drive="$HOME/.local/bin/notifications/icons/Dracula/flash-drive.png" 
     icon_palette="$HOME/.local/bin/notifications/icons/Dracula/palette.png" 
     icon_archive="$HOME/.local/bin/notifications/icons/Dracula/archive.png" 
  
     icon_wifi="$HOME/.local/bin/notifications/icons/Dracula/wifi.png" 
     icon_wifi_alert="$HOME/.local/bin/notifications/icons/Dracula/wifi-alert.png" 
     icon_wifi_error="$HOME/.local/bin/notifications/icons/Dracula/wifi-error.png" 
  
     icon_battery="$HOME/.local/bin/notifications/icons/Dracula/battery.png" 
     icon_battery_charging="$HOME/.local/bin/notifications/icons/Dracula/battery-charging.png" 
     icon_battery_critical="$HOME/.local/bin/notifications/icons/Dracula/battery-critical.png" 
     icon_battery_charged="$HOME/.local/bin/notifications/icons/Dracula/battery-charged.png" 
     icon_battery_low="$HOME/.local/bin/notifications/icons/Dracula/battery-low.png" 
  
     icon_brightness_full="$HOME/.local/bin/notifications/icons/Dracula/brightness-full.png" 
     icon_brightness_half="$HOME/.local/bin/notifications/icons/Dracula/brightness-half.png" 
     icon_brightness_low="$HOME/.local/bin/notifications/icons/Dracula/brightness-low.png" 
  
     icon_volume_high="$HOME/.local/bin/notifications/icons/Dracula/volume-high.png" 
     icon_volume_half="$HOME/.local/bin/notifications/icons/Dracula/volume-half.png" 
     icon_volume_mute="$HOME/.local/bin/notifications/icons/Dracula/volume-mute.png" 
  
     icon_microphone="$HOME/.local/bin/notifications/icons/Dracula/microphone.png" 
     icon_microphone_muted="$HOME/.local/bin/notifications/icons/Dracula/microphone-muted.png" 
  
     icon_mtp_desktop="$HOME/.local/bin/notifications/icons/Dracula/mtp-desktop.png" 
     icon_mtp_laptop="$HOME/.local/bin/notifications/icons/Dracula/mtp-laptop.png" 
  
     icon_package="$HOME/.local/bin/notifications/icons/Dracula/package-update.png" 
  
     rofi_theme_themes="$HOME/.config/rofi/launchers/themes/dracula.rasi" 
     rofi_theme_clipboard="$HOME/.config/rofi/launchers/clipboard/dracula.rasi" 
     rofi_theme_hyprland="$HOME/.config/rofi/launchers/hyprland/dracula.rasi" 
     rofi_theme_apps="$HOME/.config/rofi/launchers/apps/dracula.rasi" 
     rofi_theme_tools="$HOME/.config/rofi/launchers/tools/dracula.rasi" 
     rofi_theme_wifi="$HOME/.config/rofi/launchers/wifi/dracula.rasi" 
fi 
 
