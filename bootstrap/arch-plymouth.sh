#!/usr/bin/env sh

sudo git clone https://github.com/nenad/arch-beat.git /usr/share/plymouth/themes/arch-beat

sudo plymouth-set-default-theme -R arch-beat
