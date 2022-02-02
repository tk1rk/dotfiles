#!/usr/bin/env sh


# yay
cd $HOME/.local/share/ && git clone https://aur.archlinux.org/yay.git 
cd yay && makepkg -si
