#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx
source /usr/share/nvm/init-nvm.sh
export http_proxy=''
export https_proxy=''
export ftp_proxy=''
export socks_proxy=''

export PATH="$PATH:/home/vladimir/.komodoide/12.0/XRE/state" # ActiveState State Tool
