#!/usr/bin/env sh

# mv find-the-command timer files
sudo mv $ZSH_PLUGINS/find-the-command/pacman-timers.service /usr/lib/systemd/system/
sudo mv $ZSH_PLUGINS/find-the-command/pacman-timers.timer /usr/lib/systemd/system/

# unzip zredis plugin dir
unzip $ZSH_PLUGINS/zredis.zip
# zredis
sudo mkdir -p /usr/local/var/db/redis/

# for ZSH
case "$OSTYPE" in
  arch*)
    sudo pacman -Syy --needed base-devel git aria2
  ;;
esac

# Ubuntu 
sudo DEBIAN_FRONTEND=noninteractive apt install --yes cmake redis-server libhiredis-dev \
                        tree gem libfreetype6-dev libfontconfig-dev \
                        autoconf automake nodejs npm

# packer-nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim


# rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh \
    1
 
