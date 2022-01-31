#!/usr/bin/env zsh

# zinit
sh -c "$(curl -fsSL https://git.io/zinit-install)"

# rustup
 curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
 

 sudo pacman -S --needed base-devel git aria2