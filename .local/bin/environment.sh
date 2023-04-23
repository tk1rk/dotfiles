#!/usr/bin/env bash 
  
 current_theme="$(cat "$HOME"/.config/.current_theme)" 
  
 if [ "$current_theme" = "rose-pine" ]; then 
  
     icon_memory="$HOME/.local/bin/notifications/icons/RosePine/memory.png" 
     icon_bell="$HOME/.local/bin/notifications/icons/RosePine/bell-notification.png" 
     icon_alert="$HOME/.local/bin/notifications/icons/RosePine/alert.png" 
     icon_succes="$HOME/.local/bin/notifications/icons/RosePine/succes.png" 
     icon_screenshot="$HOME/.local/bin/notifications/icons/RosePine/screenshot.png" 
     icon_usb_drive="$HOME/.local/bin/notifications/icons/RosePine/flash-drive.png" 
     icon_palette="$HOME/.local/bin/notifications/icons/RosePine/palette.png" 
     icon_archive="$HOME/.local/bin/notifications/icons/RosePine/archive.png" 
      
     icon_wifi="$HOME/.local/bin/notifications/icons/RosePine/wifi.png" 
     icon_wifi_alert="$HOME/.local/bin/notifications/icons/RosePine/wifi-alert.png" 
     icon_wifi_error="$HOME/.local/bin/notifications/icons/RosePine/wifi-error.png" 
  
     icon_battery="$HOME/.local/bin/notifications/icons/RosePine/battery.png" 
     icon_battery_charging="$HOME/.local/bin/notifications/icons/RosePine/battery-charging.png" 
     icon_battery_critical="$HOME/.local/bin/notifications/icons/RosePine/battery-critical.png" 
     icon_battery_charged="$HOME/.local/bin/notifications/icons/RosePine/battery-charged.png" 
     icon_battery_low="$HOME/.local/bin/notifications/icons/RosePine/battery-low.png" 
  
     icon_brightness_full="$HOME/.local/bin/notifications/icons/RosePine/brightness-full.png" 
     icon_brightness_half="$HOME/.local/bin/notifications/icons/RosePine/brightness-half.png" 
     icon_brightness_low="$HOME/.local/bin/notifications/icons/RosePine/brightness-low.png" 
  
     icon_volume_high="$HOME/.local/bin/notifications/icons/RosePine/volume-high.png" 
     icon_volume_half="$HOME/.local/bin/notifications/icons/RosePine/volume-half.png" 
     icon_volume_mute="$HOME/.local/bin/notifications/icons/RosePine/volume-mute.png" 
  
     icon_microphone="$HOME/.local/bin/notifications/icons/RosePine/microphone.png" 
     icon_microphone_muted="$HOME/.local/bin/notifications/icons/RosePine/microphone-muted.png" 
  
     icon_mtp_desktop="$HOME/.local/bin/notifications/icons/RosePine/mtp-desktop.png" 
     icon_mtp_laptop="$HOME/.local/bin/notifications/icons/RosePine/mtp-laptop.png" 
  
     icon_package="$HOME/.local/bin/notifications/icons/RosePine/package-update.png" 
  
     rofi_theme_themes="$HOME/.config/rofi/launchers/themes/rose-pine.rasi" 
     rofi_theme_clipboard="$HOME/.config/rofi/launchers/clipboard/rose-pine.rasi" 
     rofi_theme_hyprland="$HOME/.config/rofi/launchers/hyprland/rose-pine.rasi" 
     rofi_theme_apps="$HOME/.config/rofi/launchers/apps/rose-pine.rasi" 
     rofi_theme_tools="$HOME/.config/rofi/launchers/tools/rose-pine.rasi" 
     rofi_theme_wifi="$HOME/.config/rofi/launchers/wifi/rose-pine.rasi" 
  
 elif [ "$current_theme" = "gruvbox-dark" ]; then 
  
     icon_memory="$HOME/.local/bin/notifications/icons/GruvboxDark/memory.png" 
     icon_bell="$HOME/.local/bin/notifications/icons/GruvboxDark/bell-notification.png" 
     icon_alert="$HOME/.local/bin/notifications/icons/GruvboxDark/alert.png" 
     icon_succes="$HOME/.local/bin/notifications/icons/GruvboxDark/succes.png" 
     icon_screenshot="$HOME/.local/bin/notifications/icons/GruvboxDark/screenshot.png" 
     icon_usb_drive="$HOME/.local/bin/notifications/icons/GruvboxDark/flash-drive.png" 
     icon_palette="$HOME/.local/bin/notifications/icons/GruvboxDark/palette.png" 
     icon_archive="$HOME/.local/bin/notifications/icons/GruvboxDark/archive.png" 
  
     icon_wifi="$HOME/.local/bin/notifications/icons/GruvboxDark/wifi.png" 
     icon_wifi_alert="$HOME/.local/bin/notifications/icons/GruvboxDark/wifi-alert.png" 
     icon_wifi_error="$HOME/.local/bin/notifications/icons/GruvboxDark/wifi-error.png" 
  
     icon_battery="$HOME/.local/bin/notifications/icons/GruvboxDark/battery.png" 
     icon_battery_charging="$HOME/.local/bin/notifications/icons/GruvboxDark/battery-charging.png" 
     icon_battery_critical="$HOME/.local/bin/notifications/icons/GruvboxDark/battery-critical.png" 
     icon_battery_charged="$HOME/.local/bin/notifications/icons/GruvboxDark/battery-charged.png" 
     icon_battery_low="$HOME/.local/bin/notifications/icons/GruvboxDark/battery-low.png" 
  
     icon_brightness_full="$HOME/.local/bin/notifications/icons/GruvboxDark/brightness-full.png" 
     icon_brightness_half="$HOME/.local/bin/notifications/icons/GruvboxDark/brightness-half.png" 
     icon_brightness_low="$HOME/.local/bin/notifications/icons/GruvboxDark/brightness-low.png" 
  
     icon_volume_high="$HOME/.local/bin/notifications/icons/GruvboxDark/volume-high.png" 
     icon_volume_half="$HOME/.local/bin/notifications/icons/GruvboxDark/volume-half.png" 
     icon_volume_mute="$HOME/.local/bin/notifications/icons/GruvboxDark/volume-mute.png" 
  
     icon_microphone="$HOME/.local/bin/notifications/icons/GruvboxDark/microphone.png" 
     icon_microphone_muted="$HOME/.local/bin/notifications/icons/GruvboxDark/microphone-muted.png" 
  
     icon_mtp_desktop="$HOME/.local/bin/notifications/icons/GruvboxDark/mtp-desktop.png" 
     icon_mtp_laptop="$HOME/.local/bin/notifications/icons/GruvboxDark/mtp-laptop.png" 
  
     icon_package="$HOME/.local/bin/notifications/icons/GruvboxDark/package-update.png" 
  
     rofi_theme_themes="$HOME/.config/rofi/launchers/themes/gruvbox-dark.rasi" 
     rofi_theme_clipboard="$HOME/.config/rofi/launchers/clipboard/gruvbox-dark.rasi" 
     rofi_theme_hyprland="$HOME/.config/rofi/launchers/hyprland/gruvbox-dark.rasi" 
     rofi_theme_apps="$HOME/.config/rofi/launchers/apps/gruvbox-dark.rasi" 
     rofi_theme_tools="$HOME/.config/rofi/launchers/tools/gruvbox-dark.rasi" 
     rofi_theme_wifi="$HOME/.config/rofi/launchers/wifi/gruvbox-dark.rasi" 
  
 elif [ "$current_theme" = "gruvbox-light" ]; then 
  
     icon_memory="$HOME/.local/bin/notifications/icons/GruvboxLight/memory.png" 
     icon_bell="$HOME/.local/bin/notifications/icons/GruvboxLight/bell-notification.png" 
     icon_alert="$HOME/.local/bin/notifications/icons/GruvboxLight/alert.png" 
     icon_succes="$HOME/.local/bin/notifications/icons/GruvboxLight/succes.png" 
     icon_screenshot="$HOME/.local/bin/notifications/icons/GruvboxLight/screenshot.png" 
     icon_usb_drive="$HOME/.local/bin/notifications/icons/GruvboxLight/flash-drive.png" 
     icon_palette="$HOME/.local/bin/notifications/icons/GruvboxLight/palette.png" 
     icon_archive="$HOME/.local/bin/notifications/icons/GruvboxLight/archive.png" 
  
     icon_wifi="$HOME/.local/bin/notifications/icons/GruvboxLight/wifi.png" 
     icon_wifi_alert="$HOME/.local/bin/notifications/icons/GruvboxLight/wifi-alert.png" 
     icon_wifi_error="$HOME/.local/bin/notifications/icons/GruvboxLight/wifi-error.png" 
  
     icon_battery="$HOME/.local/bin/notifications/icons/GruvboxLight/battery.png" 
     icon_battery_charging="$HOME/.local/bin/notifications/icons/GruvboxLight/battery-charging.png" 
     icon_battery_critical="$HOME/.local/bin/notifications/icons/GruvboxLight/battery-critical.png" 
     icon_battery_charged="$HOME/.local/bin/notifications/icons/GruvboxLight/battery-charged.png" 
     icon_battery_low="$HOME/.local/bin/notifications/icons/GruvboxLight/battery-low.png" 
  
     icon_brightness_full="$HOME/.local/bin/notifications/icons/GruvboxLight/brightness-full.png" 
     icon_brightness_half="$HOME/.local/bin/notifications/icons/GruvboxLight/brightness-half.png" 
     icon_brightness_low="$HOME/.local/bin/notifications/icons/GruvboxLight/brightness-low.png" 
  
     icon_volume_high="$HOME/.local/bin/notifications/icons/GruvboxLight/volume-high.png" 
     icon_volume_half="$HOME/.local/bin/notifications/icons/GruvboxLight/volume-half.png" 
     icon_volume_mute="$HOME/.local/bin/notifications/icons/GruvboxLight/volume-mute.png" 
  
     icon_microphone="$HOME/.local/bin/notifications/icons/GruvboxLight/microphone.png" 
     icon_microphone_muted="$HOME/.local/bin/notifications/icons/GruvboxLight/microphone-muted.png" 
  
     icon_mtp_desktop="$HOME/.local/bin/notifications/icons/GruvboxLight/mtp-desktop.png" 
     icon_mtp_laptop="$HOME/.local/bin/notifications/icons/GruvboxLight/mtp-laptop.png" 
  
     icon_package="$HOME/.local/bin/notifications/icons/GruvboxLight/package-update.png" 
  
     rofi_theme_themes="$HOME/.config/rofi/launchers/themes/gruvbox-light.rasi" 
     rofi_theme_clipboard="$HOME/.config/rofi/launchers/clipboard/gruvbox-light.rasi" 
     rofi_theme_hyprland="$HOME/.config/rofi/launchers/hyprland/gruvbox-light.rasi" 
     rofi_theme_apps="$HOME/.config/rofi/launchers/apps/gruvbox-light.rasi" 
     rofi_theme_tools="$HOME/.config/rofi/launchers/tools/gruvbox-light.rasi" 
     rofi_theme_wifi="$HOME/.config/rofi/launchers/wifi/gruvbox-light.rasi" 
  
 elif [ "$current_theme" = "catppuccin-mocha" ]; then 
  
     icon_memory="$HOME/.local/bin/notifications/icons/Catppuccin/memory.png" 
     icon_bell="$HOME/.local/bin/notifications/icons/Catppuccin/bell-notification.png" 
     icon_alert="$HOME/.local/bin/notifications/icons/Catppuccin/alert.png" 
     icon_succes="$HOME/.local/bin/notifications/icons/Catppuccin/succes.png" 
     icon_screenshot="$HOME/.local/bin/notifications/icons/Catppuccin/screenshot.png" 
     icon_usb_drive="$HOME/.local/bin/notifications/icons/Catppuccin/flash-drive.png" 
     icon_palette="$HOME/.local/bin/notifications/icons/Catppuccin/palette.png" 
     icon_archive="$HOME/.local/bin/notifications/icons/Catppuccin/archive.png" 
  
     icon_wifi="$HOME/.local/bin/notifications/icons/Catppuccin/wifi.png" 
     icon_wifi_alert="$HOME/.local/bin/notifications/icons/Catppuccin/wifi-alert.png" 
     icon_wifi_error="$HOME/.local/bin/notifications/icons/Catppuccin/wifi-error.png" 
  
     icon_battery="$HOME/.local/bin/notifications/icons/Catppuccin/battery.png" 
     icon_battery_charging="$HOME/.local/bin/notifications/icons/Catppuccin/battery-charging.png" 
     icon_battery_critical="$HOME/.local/bin/notifications/icons/Catppuccin/battery-critical.png" 
     icon_battery_charged="$HOME/.local/bin/notifications/icons/Catppuccin/battery-charged.png" 
     icon_battery_low="$HOME/.local/bin/notifications/icons/Catppuccin/battery-low.png" 
  
     icon_brightness_full="$HOME/.local/bin/notifications/icons/Catppuccin/brightness-full.png" 
     icon_brightness_half="$HOME/.local/bin/notifications/icons/Catppuccin/brightness-half.png" 
     icon_brightness_low="$HOME/.local/bin/notifications/icons/Catppuccin/brightness-low.png" 
  
     icon_volume_high="$HOME/.local/bin/notifications/icons/Catppuccin/volume-high.png" 
     icon_volume_half="$HOME/.local/bin/notifications/icons/Catppuccin/volume-half.png" 
     icon_volume_mute="$HOME/.local/bin/notifications/icons/Catppuccin/volume-mute.png" 
  
     icon_microphone="$HOME/.local/bin/notifications/icons/Catppuccin/microphone.png" 
     icon_microphone_muted="$HOME/.local/bin/notifications/icons/Catppuccin/microphone-muted.png" 
  
     icon_mtp_desktop="$HOME/.local/bin/notifications/icons/Catppuccin/mtp-desktop.png" 
     icon_mtp_laptop="$HOME/.local/bin/notifications/icons/Catppuccin/mtp-laptop.png" 
  
     icon_package="$HOME/.local/bin/notifications/icons/Catppuccin/package-update.png" 
  
     rofi_theme_themes="$HOME/.config/rofi/launchers/themes/catppuccin-mocha.rasi" 
     rofi_theme_clipboard="$HOME/.config/rofi/launchers/clipboard/catppuccin-mocha.rasi" 
     rofi_theme_hyprland="$HOME/.config/rofi/launchers/hyprland/catppuccin-mocha.rasi" 
     rofi_theme_apps="$HOME/.config/rofi/launchers/apps/catppuccin-mocha.rasi" 
     rofi_theme_tools="$HOME/.config/rofi/launchers/tools/catppuccin-mocha.rasi" 
     rofi_theme_wifi="$HOME/.config/rofi/launchers/wifi/catppuccin-mocha.rasi" 
  
 elif [ "$current_theme" = "nord" ]; then 
  
     icon_memory="$HOME/.local/bin/notifications/icons/Nord/memory.png" 
     icon_bell="$HOME/.local/bin/notifications/icons/Nord/bell-notification.png" 
     icon_alert="$HOME/.local/bin/notifications/icons/Nord/alert.png" 
     icon_succes="$HOME/.local/bin/notifications/icons/Nord/succes.png" 
     icon_screenshot="$HOME/.local/bin/notifications/icons/Nord/screenshot.png" 
     icon_usb_drive="$HOME/.local/bin/notifications/icons/Nord/flash-drive.png" 
     icon_palette="$HOME/.local/bin/notifications/icons/Nord/palette.png" 
     icon_archive="$HOME/.local/bin/notifications/icons/Nord/archive.png" 
  
     icon_wifi="$HOME/.local/bin/notifications/icons/Nord/wifi.png" 
     icon_wifi_alert="$HOME/.local/bin/notifications/icons/Nord/wifi-alert.png" 
     icon_wifi_error="$HOME/.local/bin/notifications/icons/Nord/wifi-error.png" 
  
     icon_battery="$HOME/.local/bin/notifications/icons/Nord/battery.png" 
     icon_battery_charging="$HOME/.local/bin/notifications/icons/Nord/battery-charging.png" 
     icon_battery_critical="$HOME/.local/bin/notifications/icons/Nord/battery-critical.png" 
     icon_battery_charged="$HOME/.local/bin/notifications/icons/Nord/battery-charged.png" 
     icon_battery_low="$HOME/.local/bin/notifications/icons/Nord/battery-low.png" 
  
     icon_brightness_full="$HOME/.local/bin/notifications/icons/Nord/brightness-full.png" 
     icon_brightness_half="$HOME/.local/bin/notifications/icons/Nord/brightness-half.png" 
     icon_brightness_low="$HOME/.local/bin/notifications/icons/Nord/brightness-low.png" 
  
     icon_volume_high="$HOME/.local/bin/notifications/icons/Nord/volume-high.png" 
     icon_volume_half="$HOME/.local/bin/notifications/icons/Nord/volume-half.png" 
     icon_volume_mute="$HOME/.local/bin/notifications/icons/Nord/volume-mute.png" 
  
     icon_microphone="$HOME/.local/bin/notifications/icons/Nord/microphone.png" 
     icon_microphone_muted="$HOME/.local/bin/notifications/icons/Nord/microphone-muted.png" 
  
     icon_mtp_desktop="$HOME/.local/bin/notifications/icons/Nord/mtp-desktop.png" 
     icon_mtp_laptop="$HOME/.local/bin/notifications/icons/Nord/mtp-laptop.png" 
  
     icon_package="$HOME/.local/bin/notifications/icons/Nord/package-update.png" 
  
     rofi_theme_themes="$HOME/.config/rofi/launchers/themes/nord.rasi" 
     rofi_theme_clipboard="$HOME/.config/rofi/launchers/clipboard/nord.rasi" 
     rofi_theme_hyprland="$HOME/.config/rofi/launchers/hyprland/nord.rasi" 
     rofi_theme_apps="$HOME/.config/rofi/launchers/apps/nord.rasi" 
     rofi_theme_tools="$HOME/.config/rofi/launchers/tools/nord.rasi" 
     rofi_theme_wifi="$HOME/.config/rofi/launchers/wifi/nord.rasi" 
  
 elif [ "$current_theme" = "dracula" ]; then 
  
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
  
 elif [ "$current_theme" = "catppuccin-latte" ]; then 
  
     icon_memory="$HOME/.local/bin/notifications/icons/CatppuccinLatte/memory.png" 
     icon_bell="$HOME/.local/bin/notifications/icons/CatppuccinLatte/bell-notification.png" 
     icon_alert="$HOME/.local/bin/notifications/icons/CatppuccinLatte/alert.png" 
     icon_succes="$HOME/.local/bin/notifications/icons/CatppuccinLatte/succes.png" 
     icon_screenshot="$HOME/.local/bin/notifications/icons/CatppuccinLatte/screenshot.png" 
     icon_usb_drive="$HOME/.local/bin/notifications/icons/CatppuccinLatte/flash-drive.png" 
     icon_palette="$HOME/.local/bin/notifications/icons/CatppuccinLatte/palette.png" 
     icon_archive="$HOME/.local/bin/notifications/icons/CatppuccinLatte/archive.png" 
  
     icon_wifi="$HOME/.local/bin/notifications/icons/CatppuccinLatte/wifi.png" 
     icon_wifi_alert="$HOME/.local/bin/notifications/icons/CatppuccinLatte/wifi-alert.png" 
     icon_wifi_error="$HOME/.local/bin/notifications/icons/CatppuccinLatte/wifi-error.png" 
  
     icon_battery="$HOME/.local/bin/notifications/icons/CatppuccinLatte/battery.png" 
     icon_battery_charging="$HOME/.local/bin/notifications/icons/CatppuccinLatte/battery-charging.png" 
     icon_battery_critical="$HOME/.local/bin/notifications/icons/CatppuccinLatte/battery-critical.png" 
     icon_battery_charged="$HOME/.local/bin/notifications/icons/CatppuccinLatte/battery-charged.png" 
     icon_battery_low="$HOME/.local/bin/notifications/icons/CatppuccinLatte/battery-low.png" 
  
     icon_brightness_full="$HOME/.local/bin/notifications/icons/CatppuccinLatte/brightness-full.png" 
     icon_brightness_half="$HOME/.local/bin/notifications/icons/CatppuccinLatte/brightness-half.png" 
     icon_brightness_low="$HOME/.local/bin/notifications/icons/CatppuccinLatte/brightness-low.png" 
  
     icon_volume_high="$HOME/.local/bin/notifications/icons/CatppuccinLatte/volume-high.png" 
     icon_volume_half="$HOME/.local/bin/notifications/icons/CatppuccinLatte/volume-half.png" 
     icon_volume_mute="$HOME/.local/bin/notifications/icons/CatppuccinLatte/volume-mute.png" 
  
     icon_microphone="$HOME/.local/bin/notifications/icons/CatppuccinLatte/microphone.png" 
     icon_microphone_muted="$HOME/.local/bin/notifications/icons/CatppuccinLatte/microphone-muted.png" 
  
     icon_mtp_desktop="$HOME/.local/bin/notifications/icons/CatppuccinLatte/mtp-desktop.png" 
     icon_mtp_laptop="$HOME/.local/bin/notifications/icons/CatppuccinLatte/mtp-laptop.png" 
  
     icon_package="$HOME/.local/bin/notifications/icons/CatppuccinLatte/package-update.png" 
  
     rofi_theme_themes="$HOME/.config/rofi/launchers/themes/dracula.rasi" 
     rofi_theme_clipboard="$HOME/.config/rofi/launchers/clipboard/dracula.rasi" 
     rofi_theme_hyprland="$HOME/.config/rofi/launchers/hyprland/dracula.rasi" 
     rofi_theme_apps="$HOME/.config/rofi/launchers/apps/dracula.rasi" 
     rofi_theme_tools="$HOME/.config/rofi/launchers/tools/dracula.rasi" 
     rofi_theme_wifi="$HOME/.config/rofi/launchers/wifi/dracula.rasi" 
 fi 
 
