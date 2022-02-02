#!/usr/bin/env sh


# paru
cd $HOME/.local/share/ && git clone https://aur.archlinux.org/paru.git \
cd paru && makepkg
