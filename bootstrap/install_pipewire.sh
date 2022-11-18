#!/usr/bin/env sh
# ---------------------------
# This is a bash script for configuring Arch for pro audio USING PIPEWIRE.
# ---------------------------
# NOTE: Execute this script by running the following command on your system:
# wget -O - https://raw.githubusercontent.com/brendaningram/install-scripts/main/arch/install-audio-pipewire.sh | bash

# Exit if any command fails
set -e

# TODO: Copy jack.conf to ~/.config/pipewire/jack.conf and make appropriate changes
mkdir -p ~/.config/pipewire
sudo cp /usr/share/pipewire/jack.conf ~/.config/pipewire/jack.conf

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


