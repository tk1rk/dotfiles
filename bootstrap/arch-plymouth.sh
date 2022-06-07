#!/usr/bin/env sh

sudo git clone https://github.com/dreamsmasher/Arch-Wireframe-Plymouth-Theme /usr/share/plymouth/themes/arch-wireframe

sudo plymouth-set-default-theme -R arch-wireframe
