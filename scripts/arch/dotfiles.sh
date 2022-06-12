#!/bin/sh

set -x

origin="https://v-l-a-d-i-m-i-r@github.com/v-l-a-d-i-m-i-r/.dotfiles.git"
repo_dir_name=".dotfiles"
backup_folder_name=".dotfiles-backup"

function dotfiles() {
  /usr/bin/git --git-dir=${HOME}/${repo_dir_name}/ --work-tree=${HOME} $@
}

mkdir -p ${HOME}/${backup_folder_name}

git clone --bare ${origin} ${HOME}/.dotfiles

dotfiles checkout

if [ $? -e 0 ]; then
  echo "Checked out config.";
else
  echo "Backing up pre-existing dot files.";
  dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv ${HOME}/{} ${HOME}/${backup_folder_name}/{}
fi;

dotfiles checkout

dotfiles config user.name "v-l-a-d-i-m-i-r"
dotfiles config user.email "vladimir-dan88@yandex.ru"

# ${dotfiles} fetch origin master
# # ${dotfiles} stash
# # ${dotfiles} checkout master
# ${dotfiles} reset --hard origin/master
# ${dotfiles} pull origin master