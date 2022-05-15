#!/usr/bin/env sh

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

theme="launchpad"
dir="$HOME/.config/rofi/themes/"

# comment these lines to disable random style
#themes=($(ls -p --hide="launcher.sh" $dir))
#theme="${themes[$(( $RANDOM % 16 ))]}"

rofi -no-lazy-grab -show drun -modi drun -theme $dir/"launchpad"
