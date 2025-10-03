zstyle :compinstall filename '~/.zshrc'

zstyle ':completion:*' menu select

autoload -U colors && colors
autoload -Uz compinit && compinit -i

# a => (A | a)
# A => (A)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# a => (A | a)
# A => (A | a)
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# a => (a ? a : A)
# A => (A ? A : a)
# zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

[[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)

compdef kubecolor=kubectl

# Load Angular CLI autocompletion.
if which ng >/dev/null 2>&1; then
  source <(ng completion script)
fi
