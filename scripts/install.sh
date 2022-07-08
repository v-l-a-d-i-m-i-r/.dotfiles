#!/bin/sh

# apt update && apt upgrade
# apt install -y git

# adduser remote-ws
# usermod -aG sudo remote-ws

# mkdir -p /home/remote-ws/.ssh
# touch /home/remote-ws/.ssh/authorized_keys
# chown -R remote-ws:remote-ws /home/remote-ws/
# chown root:root /home/remote-ws
# chmod 700 /home/remote-ws/.ssh
# chmod 644 /home/remote-ws/.ssh/authorized_keys
# cp /root/.ssh/authorized_keys /home/remote-ws/.ssh/authorized_keys

# mkdir -p /data && chmod -R 777 /data

# cd ~
# git init
# git remote add origin https://github.com/v-l-a-d-i-m-i-r/.dotfiles.git
# git fetch origin remote-debian
# git pull origin remote-debian

set -e;

install_utils () {
  sudo apt install -y tmux fzf fd-find ripgrep reptyr bat python2 make cmake
}

install_zsh () {
  sudo apt install -y zsh zsh-syntax-highlighting zsh-autosuggestions
  sudo chsh -s /bin/zsh $USER
}
install_diff_so_fancy() {
  sudo apt install -y snapd
  sudo snap install core
  sudo snap install diff-so-fancy
}

install_docker_and_compose() {
  sudo apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
  sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/debian \
     $(lsb_release -cs) \
     stable"
  sudo apt update
  sudo apt -y install docker-ce docker-ce-cli containerd.io
  sudo systemctl enable --now docker
  sudo usermod -aG docker $USER
  newgrp docker
}

install_neovim() {
  sudo apt install gcc clang g++
  sudo snap install nvim --classic
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/0.11.0/plug.vim'
}

install_utils
install_zsh
install_diff_so_fancy
install_neovim
install_docker_and_compose
