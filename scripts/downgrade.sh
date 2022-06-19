#!/bin/sh

set -ex

# XFCE power manager (1.6.6-1)
sudo pacman -U https://archive.archlinux.org/packages/x/xfce4-power-manager/xfce4-power-manager-1.6.6-1-x86_64.pkg.tar.zst --noconfirm

# XFCE notification daemon (0.6.1-1)
sudo pacman -U https://archive.archlinux.org/packages/x/xfce4-notifyd/xfce4-notifyd-0.6.1-1-x86_64.pkg.tar.zst --noconfirm

# Rofi (0.6.1-1)
sudo pacman -U https://archive.archlinux.org/packages/r/rofi/rofi-1.6.1-1-x86_64.pkg.tar.zst --noconfirm