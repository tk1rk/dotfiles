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
    sudo pacman -Syy --needed neofetch-btw j
git aria2 hub axe mpc mpd cmake redis-git eredis-git fastoredis hiredis-git tree treefetch-bin gem freetype2-git lib32-freetype2-git lib32-fontconfig-git fontconfig-git nerd-fonts-fontconfig base-devel nodejs npm
  ;;
esac

#  Rust tools
if ! [ -x "$(command -v cargo)" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if ! command -v rust_analyzer &> /dev/null ; then
    git clone https://github.com/rust-analyzer/rust-analyzer ~/build/rust-analyzer
    cd ~/build/rust-analyzer
    cargo xtask install --server
fi

cargo install \
  git-trim \
  ripgrep \
  broot \
  starship
  tre-command \
  lsd \
  exa 

# to enable Rofi dmenu emulation
ln -s /usr/bin/rofi /usr/bin/dmenu

# pip
python -m ensurepip --upgrade
python -m pip install --upgrade pip
pip install --user dmenu-hotkeys
dmenu_hotkeys
