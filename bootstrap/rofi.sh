#!/usr/bin/env sh

git clone --depth=1 https://github.com/adi1090x/rofi.git $HOME/.config/rofi

cd $HOME/.config/rofi
chmod +x setup.sh

./setup.sh
