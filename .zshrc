# The following lines were added by compinstall
zstyle :compinstall filename '/home/vladimir/.zshrc'

zstyle ':completion:*' menu select

autoload -U colors && colors
autoload -Uz compinit
compinit -i

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word


# zsh plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/lib/zsh-git-prompt/zshrc.sh

zstyle ':completion:*' menu select

PROMPT='%F{yellow}[%f%F{green}%~%b%f%F{yellow}]%f '
RPROMPT='$(git_super_status)'

# kubectl
source <(kubectl completion zsh)

# nvm
[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/nvm.sh
source /usr/share/nvm/install-nvm-exec
nvm use default > /dev/null

# dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# docker-compose completion
# fpath=(~/.zsh/plugins/ $fpath)

# Docker
alias docker-stop='/usr/bin/docker stop $(docker ps -a -q)'
alias docker-rm='/usr/bin/docker rm -f $(docker ps -a -q)'
alias docker-rmi='/usr/bin/docker rmi -f $(docker images -q)'
alias docker-image='docker run -v /var/run/docker.sock:/var/run/docker.sock --rm hub.docker.com/r/chenzj/dfimage'
alias docker-stats='watch --interval 1 docker stats --no-stream'
function docker-tags () {
# https://stackoverflow.com/questions/28320134/how-can-i-list-all-tags-for-a-docker-image-on-a-remote-registry
if [ $# -lt 1 ]
then
cat << HELP

dockertags  --  list all tags for a Docker image on a remote registry.

EXAMPLE:
  - list all tags for ubuntu:
    dockertags ubuntu

  - list all php tags containing apache:
    dockertags php apache

HELP
fi

image="$1"
tags=`wget -q https://registry.hub.docker.com/v1/repositories/${image}/tags -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}'`

if [ -n "$2" ]
then
  tags=` echo "${tags}" | grep "$2" `
fi

echo "${tags}"
}

# Docker Compose
alias dcd='/usr/bin/docker-compose down'
alias dcub='/usr/bin/docker-compose up --build'

# kubernetes aliases
alias k='kubectl '
alias kx='kubectx '
alias kn='kubens '
alias ke='kubectl exec -it '
# get
alias kg='kubectl get po '
alias kgg='kubectl get po | grep '
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

#Kowl
function kowl() { docker run --network=host -p 8080:8080 -e KAFKA_BROKERS=$1 quay.io/cloudhut/kowl:master }

# Terminal colors
function colors() {
  for i in {0..255} ; do
    printf "\x1b[38;5;${i}m%3d " "${i}"
    if (( $i == 15 )) || (( $i > 15 )) && (( ($i-15) % 12 == 0 )); then
      echo;
    fi
  done

  # for x in {0..8}; do
  #   for i in {30..37}; do
  #     for a in {40..47}; do
  #       echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
  #     done
  #     echo
  #   done
  # done
  # echo ""

  echo -e "\033[0mNC (No color)"
  echo -e "\033[1;37mWHITE\t\033[0;30mBLACK"
  echo -e "\033[0;34mBLUE\t\033[1;34mLIGHT_BLUE"
  echo -e "\033[0;32mGREEN\t\033[1;32mLIGHT_GREEN"
  echo -e "\033[0;36mCYAN\t\033[1;36mLIGHT_CYAN"
  echo -e "\033[0;31mRED\t\033[1;31mLIGHT_RED"
  echo -e "\033[0;35mPURPLE\t\033[1;35mLIGHT_PURPLE"
  echo -e "\033[0;33mYELLOW\t\033[1;33mLIGHT_YELLOW"
  echo -e "\033[1;30mGRAY\t\033[0;37mLIGHT_GRAY"
}

# alias devs='git shortlog -sen'
# alias l='git log --pretty=format:"%C(yellow)%h%C(reset)%<|(30)   %C(blue)%an%C(reset)%<|(47) %C(green)%ar%C(reset) %s%C(red)%d%C(reset)" --graph -16'
# alias ls='git log --pretty=format:"%C(yellow)%h%C(reset)%<|(30)  %C(blue)%an%C(reset)%<|(47) %C(green)%ar%C(reset) %s%C(red)%d%C(reset)" --graph'
# alias lf='git log --pretty=format:"%C(yellow)%h%C(reset) %s%C(red)%d%C(reset)%n%C(cyan)a%C(reset) %C(blue)%ae%C(reset) %C(green)%ar% / %ad%C(reset)%n%C(cyan)c%C(reset) %C(blue)%ce%C(reset) %C(green)%cr / %cd%C(reset)%n" --graph --date=local'
# alias ll='git log --pretty=format:"%C(yellow)%h%C(reset) %s%C(red)%d%C(reset)%n%C(cyan)a%C(reset) %C(blue)%ae%C(reset) %C(green)%ar% / %ad%C(reset)%n%C(cyan)c%C(reset) %C(blue)%ce%C(reset) %C(green)%cr / %cd%C(reset)%n" --graph --date=local -8'
# alias lg='git log --pretty=format:"%C(yellow)%h%C(reset)%<|(30)  %C(blue)%an%C(reset)%<|(47) %C(green)%ar%C(reset) %s%C(red)%d%C(reset)" -E -i --grep'

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /data/projects/pos-datamanagement/node_modules/tabtab/.completions/serverless.zsh ]] && . /data/projects/pos-datamanagement/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /data/projects/pos-datamanagement/node_modules/tabtab/.completions/sls.zsh ]] && . /data/projects/pos-datamanagement/node_modules/tabtab/.completions/sls.zsh[[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)