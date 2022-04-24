#!/usr/bin/env sh


# yay
mkdir -p $HOME/.local/share && cd $HOME/.local/share
git clone https://aur.archlinux.org/yay.git && cd yay
makepkg -si
