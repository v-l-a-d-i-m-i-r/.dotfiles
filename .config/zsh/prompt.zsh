# https://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html
# https://gist.github.com/knadh/123bca5cfdae8645db750bfb49cb44b0

autoload -Uz vcs_info

# start colors
BG_PRIMARY="#22282a";
BG_SECONDARY="#2c3335";
BG_SELECTION="#384145";
FG_COMMENTS="#505d62";
FG_SECONDARY="#97a5aa";
FG_PRIMARY="#b9c2c6";
FG_TERTIARY="#c4cccf";
BG_TERTIARY="#dbdfe1";
RED="#cc5733";
ORANGE="#ce9178";
YELLOW="#cdcd9d";
GREEN="#41a490";
CYAN="#94cceb";
BLUE="#5496d4";
PURPLE="#646696";
PINK="#bb81c5";
# end colors

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "%F{green} %b%f"
zstyle ':vcs_info:git*' actionformats "%F{green} %b%f %F{red}%a%f"

setopt prompt_subst

function preexec() {
  timer=$(date +%s%3N)
  vcs_info
}

function precmd() {
  # vcs_info
  local node=$(node -v 2> /dev/null)
  local git=$(git branch 2> /dev/null)
  local k8s=$(kubectl config current-context 2> /dev/null)

  local prompt_elapsed
  # local prompt_git=" ${vcs_info_msg_0_}"
  local prompt_git
  local prompt_node
  local prompt_k8s

  if [ $timer ]; then
    local elapsed
    local now=$(date +%s%3N)
    local d_ms=$(($now-$timer))
    local d_s=$((d_ms / 1000))
    local ms=$((d_ms % 1000))
    local s=$((d_s % 60))
    local m=$(((d_s / 60) % 60))
    local h=$((d_s / 3600))

    if ((h > 0)); then elapsed=${h}h${m}m
    elif ((m > 0)); then elapsed=${m}m${s}s
    elif ((s >= 10)); then elapsed=${s}.$((ms / 100))s
    elif ((s > 0)); then elapsed=${s}.$((ms / 10))s
    else elapsed=${ms}ms
    fi

    prompt_elapsed=" %F{$FG_COMMENTS}祥${elapsed}%{$reset_color%}"

    unset timer
  fi

  if [ $node ]; then
    prompt_node=" %F{$BLUE} ${node:1}%f"
  fi

  if [ $git ]; then
    prompt_git=" %F{$GREEN}$(git branch | grep '*' | awk '{$1=""; print $0}')%f"
  fi
  
  if [ $k8s ]; then
    prompt_k8s=" %F{$YELLOW}ﴱ ${k8s}%f"
  fi

  RPROMPT="${prompt_elapsed}${prompt_node}${prompt_git}${prompt_k8s}"
}
function _load_prompt() {
  local prompt_path='%F{$YELLOW}%~%b%f'
  local prompt_zvm=''

  case $ZVM_MODE in
    $ZVM_MODE_NORMAL)
      prompt_zvm='%F{$BG_PRIMARY}%K{$BLUE}%B NORMAL %b%f%k%F{default}%K{default}'
    ;;
    $ZVM_MODE_INSERT)
      prompt_zvm='%F{$BG_PRIMARY}%K{$GREEN}%B INSERT %b%f%k%F{default}%K{default}'
    ;;
    $ZVM_MODE_VISUAL)
      prompt_zvm='%F{$BG_PRIMARY}%K{$ORANGE}%B VISUAL %b%f%k%F{default}%K{default}'
    ;;
    $ZVM_MODE_VISUAL_LINE)
      prompt_zvm='%F{$BG_PRIMARY}%K{$ORANGE}%B V-LINE %b%f%k%F{default}%K{default}'
    ;;
    $ZVM_MODE_REPLACE)
      prompt_zvm='%F{$BG_PRIMARY}%K{$RED}%B REPLACE %b%f%k%F{default}%K{default}'
    ;;
  esac

  PROMPT="${prompt_zvm} ${prompt_path} "
}
function zvm_after_select_vi_mode() {
  _load_prompt
}

_load_prompt
