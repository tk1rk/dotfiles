#!/usr/bin/env sh

#paru -S pipewirepipewire-{alsa,jack,media-session,pulse,jack-dropin}

paru -S meson
git clone https://gitlab.freedesktop.org/pipewire/pipewire.git
cd pipewire

sudo meson setup builddir
sudo meson configure builddir
sudo meson configure builddir -Dprefix=/usr # Default: /usr/local
ninja -C builddir

sudo meson install

sudo systemctl --user start pipewire.service pipewire.socket

sudo systemctl --user start pipewire-media-session.service

sudo systemctl --user enable pipewire-media-session.service


#alsa 
#On Fedora:
/usr/lib64/alsa-lib/libasound_module_pcm_pipewire.so
#On Ubuntu:
/usr/lib/x86_64-linux-gnu/alsa-lib/libasound_module_pcm_pipewire.so
#There is also a config file installed in:
/usr/share/alsa/alsa.conf.d/50-pipewire.conf
#The plugin will be picked up by alsa when the following files
#are in /etc/alsa/conf.d/
sudo mv /etc/alsa/conf.d/50-pipewire.conf -> /usr/share/alsa/alsa.conf.d/50-pipewire.conf
sudo mv /etc/alsa/conf.d/99-pipewire-default.conf


#pulseaudio replacement (if necessary) p)
#/usr/bin/pipewire-pulse
sudo systemctl --user start pipewire-pulse.service pipewire-pulse.socket








systemctl --user start pipewire.service \
                      pipewire.socket \
                      pipewire-media-session.service \
                      pipewire-pulse.service \
                      pipewire-pulse.socket
