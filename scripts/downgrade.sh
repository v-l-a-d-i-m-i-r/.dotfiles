#!/bin/sh

set -ex

# XFCE power manager (1.6.6-1)
sudo pacman -U https://archive.archlinux.org/packages/x/xfce4-power-manager/xfce4-power-manager-1.6.6-1-x86_64.pkg.tar.zst --noconfirm

# XFCE notification daemon (0.6.1-1)
sudo pacman -U https://archive.archlinux.org/packages/x/xfce4-notifyd/xfce4-notifyd-0.6.1-1-x86_64.pkg.tar.zst --noconfirm

# Rofi (0.6.1-1)
sudo pacman -U https://archive.archlinux.org/packages/r/rofi/rofi-1.6.1-1-x86_64.pkg.tar.zst --noconfirm

# neovim
sudo pacman -U https://archive.archlinux.org/packages/l/libvterm01/libvterm01-0.1.4-2-x86_64.pkg.tar.zst
sudo pacman -U https://archive.archlinux.org/packages/n/neovim/neovim-0.7.2-3-x86_64.pkg.tar.zst 
