#!/bin/sh

set -ex

# ## Yaourt
# echo -e '[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf
# sudo pacman -Syu
# sudo pacman -Sy yaourt

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

install_from_git package-query;
install_from_git yaourt;
