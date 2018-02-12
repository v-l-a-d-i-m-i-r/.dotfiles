# The following lines were added by compinstall
zstyle :compinstall filename '/home/vladimir/.zshrc'

zstyle ':completion:*' menu select

autoload -U colors && colors

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# zsh plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/lib/zsh-git-prompt/zshrc.sh

zstyle ':completion:*' menu select

PROMPT='%F{yellow}[%f%F{green}%~%b%f%F{yellow}]%f '
RPROMPT='$(git_super_status)'

# nvm
[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/nvm.sh
source /usr/share/nvm/install-nvm-exec

# dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# docker-compose completion
# fpath=(~/.zsh/plugins/ $fpath)

autoload -Uz compinit
compinit -i
