# run
git init --bare $HOME/.dotfiles

# add to .zshrc
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

dotfiles config user.name "<user name>"
dotfiles config user.email "<user email>"

dotfiles remote add origin <origin url>

dotfiles commit -m "<message>"

dotfiles push origin master
