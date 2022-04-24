#!/usr/bin/env sh


# paru
mkdir -p $HOME/.local/share && cd $HOME/.local/share
git clone https://aur.archlinux.org/paru.git && cd paru
makepkg -si