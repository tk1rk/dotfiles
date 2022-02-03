#!/usr/bin/env sh


# for ZSH
case "$OSTYPE" in
  arch*)
    sudo pacman -Syy --needed base-devel git aria2
  ;;
esac

# zredis
sudo mkdir -p /usr/local/car/db/redia/

sudo DEBIAN_FRONTEND=noninteractive apt install --yes cmake redis-server libhiredis-dev \
                        tree gem libfreetype6-dev libfontconfig-dev \
                        autoconf automake nodejs npm

# rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh \
    1
 
