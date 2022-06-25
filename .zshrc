zstyle :compinstall filename '~/.zshrc'

zstyle ':completion:*' menu select

autoload -U colors && colors
autoload -Uz compinit
compinit -i

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

source ~/.zshenv
source ~/.config/zsh/nvm.zsh
source ~/.config/zsh/prompt.zsh
source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/functions.zsh

# zsh plugins
add_plugin 'jeffreytse/zsh-vi-mode' 'v0.8.5'
add_plugin 'zsh-users/zsh-autosuggestions' 'v0.7.0'
add_plugin 'zsh-users/zsh-syntax-highlighting' '0.7.1'

# kubectl
# [[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)

# docker-compose completion
# fpath=(~/.zsh/plugins/ $fpath)

