# The following lines were added by compinstall
zstyle :compinstall filename '/home/vladimir/.zshrc'

zstyle ':completion:*' menu select

autoload -U colors && colors

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word


# shift-arrow() {
#   ((REGION_ACTIVE)) || zle set-mark-command
#   zle $1
# }
# shift-left() shift-arrow backward-char
# shift-right() shift-arrow forward-char
# shift-up() shift-arrow up-line-or-history
# shift-down() shift-arrow down-line-or-history
# zle -N shift-left
# zle -N shift-right
# zle -N shift-up
# zle -N shift-down

# bindkey $terminfo[kLFT] shift-left
# bindkey $terminfo[kRIT] shift-right
# bindkey $terminfo[kri] shift-up
# bindkey $terminfo[kind] shift-down

#########################################################
# # define commands to copy and paste x clipboard

# # ^Xw - copy region, or cut buffer
# # ^Xy - paste x clipboard

# # in both cases, modifies CUTBUFFER

# copy-to-xclip() {
#     [[ "$REGION_ACTIVE" -ne 0 ]] && zle copy-region-as-kill
#     print -rn -- $CUTBUFFER | xclip -selection clipboard -i
# }

# zle -N copy-to-xclip
# bindkey "^Xw" copy-to-xclip

# paste-xclip() {
#     killring=("$CUTBUFFER" "${(@)killring[1,-2]}")
#     CUTBUFFER=$(xclip -selection clipboard -o)
#     zle yank
# }

# zle -N paste-xclip
# bindkey "^Xy" paste-xclip
########################################################
# bindkey -e

# function zle-line-init {
#     marking=0
# }
# zle -N zle-line-init

# function select-char-right {
#     if (( $marking != 1 ))
#     then
#         marking=1
#         zle set-mark-command
#     fi
#     zle .forward-char
# }
# zle -N select-char-right

# function select-char-left {
#     if (( $marking != 1 ))
#     then
#         marking=1
#         zle set-mark-command
#     fi
#     zle .backward-char
# }
# zle -N select-char-left

# function forward-char {
#     if (( $marking == 1 ))
#     then
#         marking=0
#         NUMERIC=-1 zle set-mark-command
#     fi
#     zle .forward-char
# }
# zle -N forward-char

# function backward-char {
#     if (( $marking == 1 ))
#     then
#         marking=0
#         NUMERIC=-1 zle set-mark-command
#     fi
#     zle .backward-char
# }
# zle -N backward-char

# function delete-char {
#     if (( $marking == 1 ))
#     then
#         zle kill-region
#         marking=0
#     else
#         zle .delete-char
#     fi
# }
# zle -N delete-char

# bindkey '^[[1;2D' select-char-left   # assuming xterm
# bindkey '^[[1;2C' select-char-right  # assuming xterm

#######################
# ~/.minttyrc
# ScrollMod=2

# r-delregion() {
#     if ((REGION_ACTIVE)) then
#        zle kill-region
#     else
#        zle $1
#     fi
# }

# r-deselect() {
#     ((REGION_ACTIVE = 0))
#     zle $1
# }

# r-select() {
#   ((REGION_ACTIVE)) || zle set-mark-command
#   zle $1
# }

# for key     kcap    seq        mode      widget (
#     sleft   kLFT    $'\e[1;2D' select    backward-char
#     sright  kRIT    $'\e[1;2C' select    forward-char
#     sup     kri     $'\e[1;2A' select    up-line-or-history
#     sdown   kind    $'\e[1;2B' select    down-line-or-history

#     send    kEND    $'\E[1;2F' select    end-of-line
#     send2   x       $'\E[4;2~' select    end-of-line

#     shome   kHOM    $'\E[1;2H' select    beginning-of-line
#     shome2  x       $'\E[1;2~' select    beginning-of-line

#     left    kcub1   $'\EOD'    deselect  backward-char
#     right   kcuf1   $'\EOC'    deselect  forward-char

#     end     kend    $'\EOF'    deselect  end-of-line
#     end2    x       $'\E4~'    deselect  end-of-line

#     home    khome   $'\EOH'    deselect  beginning-of-line
#     home2   x       $'\E1~'    deselect  beginning-of-line

#     csleft  x       $'\E[1;6D' select    backward-word
#     csright x       $'\E[1;6C' select    forward-word
#     csend   x       $'\E[1;6F' select    end-of-line
#     cshome  x       $'\E[1;6H' select    beginning-of-line

#     cleft   x       $'\E[1;5D' deselect  backward-word
#     cright  x       $'\E[1;5C' deselect  forward-word

#     del     kdch1   $'\E[3~'   delregion delete-char
#     bs      x       $'^?'      delregion backward-delete-char

#   ) {
#   eval "key-$key() r-$mode $widget"
#   zle -N key-$key
#   bindkey ${terminfo[$kcap]-$seq} key-$key
# }
###########################################################################

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
nvm use default > /dev/null

# dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# docker-compose completion
# fpath=(~/.zsh/plugins/ $fpath)

autoload -Uz compinit
compinit -i

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

# Git
function gfcp() { git fetch origin $1 && git checkout $1 && git pull origin $1 }
function ga() { git add $1 }
function gcm() { git commit -m "$1" }
alias gpc='git push origin `git rev-parse --abbrev-ref HEAD`'

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
[[ -f /data/projects/pos-datamanagement/node_modules/tabtab/.completions/sls.zsh ]] && . /data/projects/pos-datamanagement/node_modules/tabtab/.completions/sls.zsh