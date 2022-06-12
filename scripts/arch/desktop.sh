#!/bin/sh

set -ex

## Synchronize the database and update the packages
sudo pacman -Sy --noconfirm

## Mirrorlists
sudo pacman -S --noconfirm reflector --needed
sudo reflector --verbose --latest 100 --sort rate --save /etc/pacman.d/mirrorlist

## Update the packages
sudo pacman -Syyu --noconfirm

function aur_install() {
  yaourt -S $@ --noconfirm --needed
}

function pacman_install() {
  sudo pacman -S $@ --noconfirm --needed
}

## Xorg server
pacman_install xorg xorg-xinit mesa

## i3
pacman_install i3-wm i3lock i3blocks

## Video driver
# check the type of video card
# lspci | grep VGA
pacman_install xf86-video-intel

## Audio driver
pacman_install alsa-lib alsa-utils alsa-oss alsa-plugins pavucontrol pulseaudio
aur_install pa-applet-git

## Touchpad
pacman_install xf86-input-synaptics

## Commanders
pacman_install doublecmd-gtk2 pcmanfm lf

## Source control
pacman_install git
pacman_install diff-so-fancy

## Neovim
pacman_install neovim
pacman_install neovim-plug
### Dependencies
pacman_install python
pacman_install python-pip
aur_install    watchman-bin
### LSP servers
# pacman_install typescript-language-server
# pacman_install lua-language-server
# pacman_install bash-language-server
# aur_install    vscode-langservers-extracted
### Providers
python3 -m pip install --user --upgrade pynvim
pacman_install cpanminus
cpanm -n Neovim::Ext

## Utils
pacman_install gvfs polkit-gnome gnome-keyring gparted ntfs-3g xfce4-power-manager htop conky arandr xcompmgr nitrogen gsimplecal gvfs-mtp gvfs-gphoto2 bind-tools pacman-contrib lm_sensors seahorse
aur_install nvm grub-customizer jmtpfs
pacman_install sbxkb

## Notifications
pacman_install xfce4-notifyd

## Appearance
aur_install lxappearance qt5ct qt5-styleplugins

## Theme
pacman_install gnome-themes-extra
pacman_install papirus-icon-theme

## Archivers
pacman_install zip unzip

## Launchers
pacman_install rofi

## Network
pacman_install networkmanager networkmanager-pptp network-manager-applet

## SSH
pacman_install openssh

## Chrony
pacman_install chrony

## ZSH
pacman_install zsh
aur_install zsh-git-prompt zsh-autosuggestions zsh-syntax-highlighting

## Nano syntax highligting
aur_install nano-syntax-highlighting-git

## Browsers
pacman_install firefox

## Terminal
pacman_install rxvt-unicode
pacman_install urxvt-perls
aur_install urxvt-resize-font-git

## Fonts
pacman_install ttf-dejavu
aur_install nerd-fonts-dejavu-complete

## Images
pacman_install gwenview

## Keyboard
aur_install xkblayout-state-git
pacman_install xbindkeys

## Cli tools replacements
pacman_install lsd bat fd ripgrep zoxide

## Enable Network Manager daemon
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

## Time sync
sudo systemctl enable chronyd.service
sudo systemctl start chronyd.service

## Change shell
sudo chsh -s /bin/zsh $USER
