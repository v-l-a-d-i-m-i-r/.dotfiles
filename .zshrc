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

# Docker Compose
alias dcd='/usr/bin/docker-compose down'
alias dcub='/usr/bin/docker-compose up --build'

# Git
function gfcp() { git fetch origin $1 && git checkout $1 && git pull origin $1 }
function ga() { git add $1 }
function gcm() { git commit -m "$1" }

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /data/projects/pos-datamanagement/node_modules/tabtab/.completions/serverless.zsh ]] && . /data/projects/pos-datamanagement/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /data/projects/pos-datamanagement/node_modules/tabtab/.completions/sls.zsh ]] && . /data/projects/pos-datamanagement/node_modules/tabtab/.completions/sls.zsh