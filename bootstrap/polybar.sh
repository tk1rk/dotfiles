#!/usr/bin/env sh

mkdir -p $HOME/.config/polybar && git clone --depth=1 https://github.com/adi1090x/polybar-themes.git $HOME/.config/polybar/themes

cd $HOME/.config/polybar/themes
chmod +x setup.sh

./setup.sh

