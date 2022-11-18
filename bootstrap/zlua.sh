#!/usr/bin/env sh

# install dep's for optional module
sudo apt-get install -y musl-tools

# czmod optional module
git clone https://github.com/skywind3000/czmod.git $ZSH_PLUGINS/z.lua/ && cd $ZSH_PLUGINS/z.lua/
sh build.sh

# z.lua
