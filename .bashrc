#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx
source /usr/share/nvm/init-nvm.sh
