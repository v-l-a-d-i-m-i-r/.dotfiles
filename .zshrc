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
source ~/.config/zsh/mpv.zsh

# zoxide
eval "$(zoxide init zsh)"

# zsh plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# kubectl
[[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)

