#!/usr/bin/env sh


# for ZSH
case "$OSTYPE" in
  arch*)
    sudo pacman -Syy --needed base-devel git aria2
  ;;
esac



# rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh \
    1
 
