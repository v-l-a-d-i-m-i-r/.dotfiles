#!/bin/sh

set -ex

## Synchronize the database and update the packages
sudo pacman -Sy --noconfirm

packages=(
  ## Xorg server
  xorg
  xorg-xinit
  mesa

  ## i3
  i3-wm
  i3lock
  i3blocks
  dmenu

  ## Video driver
  # check the type of video card
  # lspci | grep VGA
  xf86-video-intel

  ## Audio driver
  alsa-lib
  alsa-utils
  alsa-oss
  alsa-plugins
  alsa-ucf-conf
  pavucontrol
  pulseaudio
  pa-applet-git
  sof-firmware # driver

  ## Touchpad
  xf86-input-synaptics

  ## Commanders
  doublecmd-gtk2
  pcmanfm

  ## Source control
  git
  diff-so-fancy

  ## Neovim
  neovim
  neovim-plug
  ### Dependencies
  python
  python-pip
  watchman-bin
  ### Providers
  cpanminus

  ## Utils
  gvfs
  polkit-gnome
  gnome-keyring
  gparted
  ntfs-3g
  xfce4-power-manager
  htop
  conky
  arandr
  xcompmgr
  nitrogen
  gsimplecal
  gvfs-mtp
  gvfs-gphoto2
  bind-tools
  pacman-contrib
  lm_sensors
  seahorse
  grub-customizer
  jmtpfs
  sbxkb

  ## Notifications
  xfce4-notifyd

  ## Appearance
  lxappearance
  qt5ct
  qt5-styleplugins

  ## Theme
  gnome-themes-extra
  papirus-icon-theme

  ## Archivers
  zip
  unzip

  ## Launchers
  rofi

  ## Network
  networkmanager
  networkmanager-pptp
  network-manager-applet

  ## SSH
  openssh

  ## Chrony
  chrony

  ## ZSH
  zsh
  zsh-git-prompt
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-vi-mode

  ## Nano syntax highligting
  nano-syntax-highlighting-git

  ## Browsers
  firefox

  ## Terminal
  rxvt-unicode
  urxvt-perls
  urxvt-resize-font-git
  xterm

  ## Fonts
  ttf-dejavu
  nerd-fonts-dejavu-complete
  noto-fonts-emoji
  libxft-bgra

  ## Images
  gwenview

  ## Keyboard
  xkblayout-state-git
  xbindkeys

  ## Cli smart tools
  lsd
  bat
  fd
  ripgrep
  zoxide
  jq
  fzf
  tmux
);

yaourt -S "${packages[@]}" --noconfirm --needed

### Providers
python3 -m pip install --user --upgrade pynvim
cpanm -n Neovim::Ext

## Enable Network Manager daemon
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

## Time sync
sudo systemctl enable chronyd.service
sudo systemctl start chronyd.service

## Change shell
sudo chsh -s /bin/zsh $USER
