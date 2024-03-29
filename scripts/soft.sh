#!/bin/sh

set -ex

## Update the packages
sudo pacman -Syyu --noconfirm

function pacman_install() {
  sudo pacman -S $@ --noconfirm --needed
}

function aur_install() {
  yaourt -S $@ --noconfirm --needed
}

## Text editors
pacman_install mousepad gedit
aur_install visual-studio-code-bin
# pacman_install code

## Engrampa
pacman_install engrampa

## Browsers
pacman_install opera falkon
aur_install google-chrome

## Messangers
# aur_install zoom
# aur_install skypeforlinux-stable-bin

## REST clients
# aur_install postman-bin
aur_install insomnia-bin

## Mongodb clients
# aur_install mongodb-compass robo3t-bin
# aur_install mongoclient
# sudo ln -s /usr/bin/Nosqlclient /opt/mongoclient/Nosqlclient

## Mongodb
# pacman_install mongodb
# pacman_install mongodb-tools

## Flameshot
aur_install flameshot

## Docker
pacman_install docker docker-compose kubectl

## Players
aur_install vlc qmplay2 youtube-dl mpv

## AUR clients
aur_install pamac-aur kalu

## Redshift
aur_install redshift-qt

# sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo systemctl enable docker
