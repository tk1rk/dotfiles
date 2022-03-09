#!/usr/bin/env bash
# ---------------------------
# This is a bash script for configuring Arch for pro audio USING PIPEWIRE.
# ---------------------------
# NOTE: Execute this script by running the following command on your system:
# wget -O - https://raw.githubusercontent.com/brendaningram/install-scripts/main/arch/install-audio-pipewire.sh | bash

# Exit if any command fails
set -e

# TODO: Copy jack.conf to ~/.config/pipewire/jack.conf and make appropriate changes
# mkdir -p ~/.config/pipewire
# sudo cp /usr/share/pipewire/jack.conf ~/.config/pipewire/jack.conf

notify () {
  echo "----------------------------------"
  echo $1
  echo "----------------------------------"
}

# ------------------------------------------------------------------------------------
# Install packages
# ------------------------------------------------------------------------------------
notify "Update our system"
sudo pacman -Syu

# Audio
notify "Install audio packages"
echo "NOTE: When prompted, select (y)es to remove pulseaudio and pulseaudio-bluetooth."
# alsa-utils: For alsamixer (to increase base level of sound card)
sudo pacman -S pipewire pipewire-alsa pipewire-jack pipewire-pulse alsa-utils helvum ardour

echo "/usr/lib/pipewire-0.3/jack" | sudo tee /etc/ld.so.conf.d/pipewire-jack.conf
sudo ldconfig


# ---------------------------
# grub
# threadirqs = TODO
# cpufreq.default_governor=performance = TODO
# ---------------------------
notify "Modify GRUB options"
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet threadirqs cpufreq.default_governor=performance"/g' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg


# ---------------------------
# limits
# ---------------------------
notify "Modify limits.d/audio.conf"
# See https://wiki.linuxaudio.org/wiki/system_configuration for more information.
echo '@audio - rtprio 90
@audio - memlock unlimited' | sudo tee -a /etc/security/limits.d/audio.conf


# ---------------------------
# sysctl.conf
# ---------------------------
notify "Modify /etc/sysctl.conf"
# See https://wiki.linuxaudio.org/wiki/system_configuration for more information.
echo 'fs.inotify.max_user_watches=600000' | sudo tee -a /etc/sysctl.conf


# ---------------------------
# Add the user to the audio group
# ---------------------------
notify "Add ourselves to the audio group"
sudo usermod -a -G audio $USER


# ------------------------------------------------------------------------------------
# Bitwig
# ------------------------------------------------------------------------------------
notify "Install Bitwig"
yay -S bitwig-studio --noconfirm


# ------------------------------------------------------------------------------------
# Reaper
# ------------------------------------------------------------------------------------
notify "Install Reaper"
wget -O reaper.tar.xz http://reaper.fm/files/6.x/reaper649_linux_x86_64.tar.xz
mkdir ./reaper
tar -C ./reaper -xf reaper.tar.xz
sudo ./reaper/reaper_linux_x86_64/install-reaper.sh --install /opt --integrate-desktop --usr-local-bin-symlink
rm -rf ./reaper
rm reaper.tar.xz


# ------------------------------------------------------------------------------------
# Wine (staging)
# ------------------------------------------------------------------------------------

# Enable multilib
sudo cp /etc/pacman.conf /etc/pacman.conf.bak
cat /etc/pacman.conf.bak | tr '\n' '\f' | sed -e 's/#\[multilib\]\f#Include = \/etc\/pacman.d\/mirrorlist/\[multilib\]\fInclude = \/etc\/pacman.d\/mirrorlist/g'  | tr '\f' '\n' | sudo tee /etc/pacman.conf
sudo pacman -Syyu

# Install wine-staging
sudo pacman -S wine-staging winetricks --noconfirm

# NOTE: If wine-staging has regressions, you may need to downgrade.
# You can do that by installing the downgrade package from AUR and
# then specifying the version of wine-staging you want.
# Note: as of 10th October 2021 the correct number is 82 (6.14)
#yay -S downgrade --noconfirm
#sudo env DOWNGRADE_FROM_ALA=1 downgrade wine-staging

# Base wine packages required for proper plugin functionality
winetricks corefonts

# ------------------------------------------------------------------------------------
# yabridge
# ------------------------------------------------------------------------------------

yay -S yabridge-bin --noconfirm

# Create common VST paths
mkdir -p "$HOME/.wine/drive_c/Program Files/Steinberg/VstPlugins"
mkdir -p "$HOME/.wine/drive_c/Program Files/Common Files/VST2"
mkdir -p "$HOME/.wine/drive_c/Program Files/Common Files/VST3"

# Add them into yabridge
yabridgectl add "$HOME/.wine/drive_c/Program Files/Steinberg/VstPlugins"
yabridgectl add "$HOME/.wine/drive_c/Program Files/Common Files/VST2"
yabridgectl add "$HOME/.wine/drive_c/Program Files/Common Files/VST3"rogram Files/Steinberg/VstPlugins"
120
mkdir -p "$HOME/.wine/drive_c/Program Files/Common Files/VST2"
121
mkdir -p "$HOME/.wine/drive_c/Program Files/Common Files/VST3"
122
​
123
# Add them into yabridge
124
yabridgectl add "$HOME/.wine/drive_c/Program Files/Steinberg/VstPlugins"
125
yabridgectl add "$HOME/.wine/drive_c/Program Files/Common Files/VST2"
126
yabridgectl add "$HOME/.wine/drive_c/Program Files/Common Files/VST3"
127
​
128
# ---------------------------
129
# Install Windows VST plugins
130
# This is a manual step for you to run when you download plugins.
131
# First, run the plugin installer .exe file
132
# When the installer asks for a directory, make sure you select
133
# one of the directories above.
134
​
135
# VST2 plugins:
136
#   C:\Program Files\Steinberg\VstPlugins
137
# OR
138
#   C:\Program Files\Common Files\VST2
139
​
140
# VST3 plugins:
141
#   C:\Program Files\Common Files\VST3
142
# ---------------------------
143
​
144
# Each time you install a new plugin, you need to run:
145
# yabridgectl sync
146
​
147
# ---------------------------
148
# FINISHED!
149
# Now just reboot, and make music!
150
# ---------------------------
151
notify "Done - please reboot."

# ---------------------------
# Install Windows VST plugins
# This is a manual step for you to run when you download plugins.
# First, run the plugin installer .exe file
# When the installer asks for a directory, make sure you select
# one of the directories above.

# VST2 plugins:
#   C:\Program Files\Steinberg\VstPlugins
# OR
#   C:\Program Files\Common Files\VST2

# VST3 plugins:
#   C:\Program Files\Common Files\VST3
# ---------------------------

# Each time you install a new plugin, you need to run:
# yabridgectl sync

# ---------------------------
# FINISHED!
# Now just reboot, and make music!
# ---------------------------
notify "Done - please reboot."
