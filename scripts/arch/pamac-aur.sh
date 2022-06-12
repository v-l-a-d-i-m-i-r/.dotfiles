#!/bin/sh

set -ex


function install_from_git() {
  local package_name=$@;

  git clone https://aur.archlinux.org/${package_name}.git;
  cd ${package_name};
  makepkg -s --noconfirm
  sudo pacman -U --noconfirm $(ls | grep pkg.tar);
  cd ..
  rm -rf ${package_name};
}

sudo pacman -Syy --noconfirm git;

install_from_git pamac-aur;