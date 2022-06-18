zstyle :compinstall filename '~/.zshrc'

zstyle ':completion:*' menu select

autoload -U colors && colors
autoload -Uz compinit
compinit -i

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# zsh plugins
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/prompt.zsh

# kubectl
# [[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)

export NVM_DIR="$HOME/.nvm"
source ~/.config/zsh/nvm.zsh

# dotfiles
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# docker-compose completion
# fpath=(~/.zsh/plugins/ $fpath)

# ls
alias ll='lsd -lah'
alias lt='lsd --tree'

# Docker
alias d='docker'
alias docker-stop='/usr/bin/docker stop $(docker ps -a -q)'
alias docker-rm='/usr/bin/docker rm -f $(docker ps -a -q)'
alias docker-rmi='/usr/bin/docker rmi -f $(docker images -q)'
alias docker-rmio='docker rmi $(docker images -f dangling=true -q)'
alias docker-image='docker run -v /var/run/docker.sock:/var/run/docker.sock --rm hub.docker.com/r/chenzj/dfimage'
alias docker-stats='watch --interval 1 docker stats --no-stream'
function docker-tags () { curl -L -s https://registry.hub.docker.com/v1/repositories/$1/tags | jq -r '.[].name' }

# Docker Compose
alias dc='docker-compose '
alias dcd='/usr/bin/docker-compose down'
alias dcub='/usr/bin/docker-compose up --build'

# kubernetes aliases
alias k='kubectl '
alias kx='kubectx '
alias kn='kubens '
alias ke='kubectl exec -it '
# get
alias kg='kubectl get po -o wide '
alias kgg='kubectl get po -o wide | grep '
function kggw() { watch "kubectl get pod -o wide | grep $1" }
alias kgd='kubectl get deployment '
alias kgdg='kubectl get deployment | grep '
alias kgs='kubectl get services '
alias kgsg='kubectl get services | grep '
# describe
alias kdp='kubectl describe po '
alias kdd='kubectl describe deployment '
alias kds='kubectl describe service '
# logs
alias kl='kubectl logs -f '
alias klt='kubectl logs -f --tail '
function kld() { k logs -f deployment/$1 --all-containers=true ${@:2}}
# alias kd='kubectl delete po '
function ked() { k edit deployment/$1 }

# Git
function gfcp() { git fetch origin $1 && git checkout $1 && git pull origin $1 }
alias g='git'
alias ga='git add '
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m '
alias gf='git fetch origin '
alias gfp='git fetch --all --tags --prune'
alias gpl='git pull origin '
alias gplc='git pull origin `git rev-parse --abbrev-ref HEAD`'
# alias gps='git push origin '
alias gpsc='git push origin `git rev-parse --abbrev-ref HEAD`'
alias gco='git checkout '
alias gcob='git checkout -b '
alias gm='git merge '
alias gg='git branch -a | tr -d \* | sed "/->/d" | xargs git grep '
function ggf() {
for branch in $(git rev-list --all)
do
  git ls-tree -r --name-only $branch | grep "$1" | sed 's/^/'$branch': /'
done
}
alias gl='git log --pretty=format:"%C(yellow)%h%C(reset)%<|(30) %C(blue)%an%C(reset)%<|(47) %C(green)%ad (%ar)%C(reset) %s%C(red)%d%C(reset)" --graph --date local'

# tmux
alias tmux='TERM=screen-256color /usr/bin/tmux -2 ' # Force tmux to assume the terminal supports 256 colours.
alias t="tmux "
function ts() {
  TERM=screen-256color 

  if [[ $# -eq 0 ]]; then
    zsh ~/.bin/tmux-sessionizer /data/projects/* ~/.config/nvim/plugins/* ~/.config/i3 ~/.config/nvim
  else
    zsh ~/.bin/tmux-sessionizer $1
  fi
}

alias bat='batcat'
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"

#Kowl
function kowl() { docker run --rm -ti --network=host -p 8080:8080 -e KAFKA_BROKERS=$1 quay.io/cloudhut/kowl:master }

#IP
function myip() { ip route get 8.8.8.8 | grep -oP 'src \K[^ ]+' }

# Safe jq
alias sjq="jq -R 'fromjson? | select(type == \"object\")'"

