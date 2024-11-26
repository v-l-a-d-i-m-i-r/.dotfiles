# dotfiles
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# ls
# alias ll='lsd -lah --group-directories-first'
alias ll='exa -liah --icons --group-directories-first -ug'
alias lt='ll --tree'
alias lz='ll --total-size'

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
alias k='kubecolor'
alias kx='kubectx '
alias kn='kubens '
alias ke='k exec -it '
# get
alias kg='k get po -o wide '
alias kgg='k get po -o wide | grep '
function kggw() { watch "k get pod -o wide | grep $1" }
alias kgd='k get deployment '
alias kgdg='k get deployment | grep '
alias kgs='k get services '
alias kgsg='k get services | grep '
# describe
alias kdp='k describe po '
alias kdd='k describe deployment '
alias kds='k describe service '
# logs
alias kl='k logs -f '
alias klt='k logs -f --tail '
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
alias gcof='git checkout $(g branch | fzf)'
alias gm='git merge '
alias gg='git branch -a | tr -d \* | sed "/->/d" | xargs git grep '
function ggf() {
  for branch in $(git rev-list --all)
  do
    git ls-tree -r --name-only $branch | grep "$1" | sed 's/^/'$branch': /'
  done
}
# alias gl='git log --pretty=format:"%C(yellow)%h%C(reset)%<|(30) %C(blue)%an%C(reset)%<|(47) %C(green)%ad%C(reset) %s%C(red)%d%C(reset)" --graph --date=format-local:"%Y-%m-%d %H:%M:%S"'
alias gl='git log --abbrev=8 --pretty=format:"%C(yellow)%h%C(reset)%<|(30) %C(blue)%an%C(reset)%<|(47) %C(green)%ad%C(reset) %s" --graph --date=format-local:"%Y-%m-%d %H:%M:%S"'
alias gla='gl --all'
alias gs='git status'


# function fzf-git-branch() {
#   git rev-parse HEAD > /dev/null 2>&1 || return
#
#   git branch --color=always --all --sort=-committerdate |
#     grep -v HEAD |
#     fzf --height 50% --ansi --no-multi --preview-window right:65% \
#       --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
#     sed "s/.* //"
# }
# function fzf-git-checkout() {
#   git rev-parse HEAD > /dev/null 2>&1 || return
#
#   local branch
#
#   branch=$(fzf-git-branch)
#   if [[ "$branch" = "" ]]; then
#     echo "No branch selected."
#     return
#   fi
#
#   # If branch name starts with 'remotes/' then it is a remote branch. By
#   # using --track and a remote branch name, it is the same as:
#   # git checkout -b branchName --track origin/branchName
#   if [[ "$branch" = 'remotes/'* ]]; then
#     git checkout --track $branch
#   else
#     git checkout $branch;
#   fi
# }
# alias gb='fzf-git-branch'
# alias gco='fzf-git-checkout'

# https://cocktailmake.github.io/posts/improvement-of-git-commands-with-fzf/
# is_in_git_repo() {
#     # git rev-parse HEAD > /dev/null 2>&1
#     git rev-parse HEAD > /dev/null
# }
# # Filter branches.
# git-br-fzf() {
#     is_in_git_repo || return
#
#     local tags branches target
#     tags=$(
# 	git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
#     branches=$(
# 	git branch --all | grep -v HEAD |
# 	    sed "s/.* //" | sed "s#remotes/[^/]*/##" |
# 	    sort -u | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
#     target=$(
# 	(echo "$tags"; echo "$branches") |
# 	    fzf --no-hscroll --no-multi --delimiter="\t" -n 2 \
# 		--ansi --preview="git log -200 --pretty=format:%s $(echo {+2..} |  sed 's/$/../' )" ) || return
#     echo $(echo "$target" | awk -F "\t" '{print $2}')
# }
# # Filter branches and checkout the selected one with <enter> key,
# git-co-fzf() {
#     is_in_git_repo || return
#     git checkout $(git-br-fzf)
# }
# # Filter commit logs. The diff is shown on the preview window.
# git-log-fzf() { # fshow - git commit browser
#     is_in_git_repo || return
#
#     _gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
#     _viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always %'"
#     git log --graph --color=always \
# 	--format="%C(auto)%h%d [%an] %s %C(black)%C(bold)%cr" "$@" |
#     fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
# 	--preview="$_viewGitLogLine" \
# 	--bind "ctrl-m:execute:
# 		(grep -o '[a-f0-9]\{7\}' | head -1 |
# 		xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
# 		{}
# FZF-EOF"
# }

# tmux
alias t='tmux '
# alias ta='~/.bin/tmux-sessionizer $(t ls | fzf | cut -d ':' -f1)'
function ta() {
  local session_name=$(tmux list-sessions -F '#{session_id}: #S' | sort| awk '{print $2}' | awk '{print NR-1 ": " $0}' | fzf | awk '{print $2}');
  ~/.bin/tmux-sessionizer "${session_name}";
}
function ts() {
  if [[ $# -eq 0 ]]; then
    folders=(
      ~/.config/i3
      ~/.config/nvim
      ~/scripts/tools/*
    )

    if [ -d /data/projects ]; then
      folders+=(/data/projects/*)
    fi

    # if [ -d ~/.config/nvim/plugins ]; then
    #   folders+=(~/.config/nvim/plugins/*)
    # fi

    if [ -d /data/projects/monorepo ]; then
      folders+=(/data/projects/monorepo/*)
    fi

    ~/.bin/tmux-sessionizer ${folders[@]}
  else
    ~/.bin/tmux-sessionizer $1
  fi
}
alias tsh='ts ~'
function tsf() {
  if [[ $# -eq 0 ]]; then
    ~/.bin/tmux-sessionizer /data/projects/flip/* 
  else
    ~/.bin/tmux-sessionizer $1
  fi
}

# npm
alias ni='npm install'
function nri() {
  npm uninstall $@ && npm install $@;
}

#Kowl
function kowl() { docker run --rm -ti --network=host -p 8080:8080 -e KAFKA_BROKERS=$1 quay.io/cloudhut/kowl:master }

#IP
function myip() { ip route get 8.8.8.8 | grep -oP 'src \K[^ ]+' }
function opened-ports() { sudo netstat -tulpn | grep LISTEN }

# Safe jq
alias sjq="jq -R 'fromjson? | select(type == \"object\")'"

# misc
alias vlp="vlc --qt-start-minimized ~/vlc-playlist.xspf"
alias sudo='sudo -Es'
alias csvtojson="python -c 'import csv, json, sys; print(json.dumps([dict(r) for r in csv.DictReader(sys.stdin)]))'"

alias nvim='/data/projects/nvim-0.10.1/bin/nvim'
alias nvimdiff='nvim -d -o'

function b64 (){
  echo $@ | base64
}

function b64d () {
  echo $@ | base64 -d
}

function pinfo() {
  cmd='(pacman -Qi {}; pactree -r {})'; pacman -Q --quiet | fzf --preview "$cmd"
}

alias pott='f() { xdg-open ${1/https:\/\/teams.microsoft.com/msteams:} }; f'
