# https://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html
# https://gist.github.com/knadh/123bca5cfdae8645db750bfb49cb44b0
# https://www.reddit.com/r/zsh/comments/cgbm24/multiline_prompt_the_missing_ingredient/
# https://superuser.com/questions/974908/multiline-rprompt-in-zsh

autoload -Uz vcs_info

# start colors
ZSH_PROMPT_PATH="#cdcd9d";
ZSH_PROMPT_ELAPSED="#505d62";
ZSH_PROMPT_NODE="#5496d4";
ZSH_PROMPT_GIT="#41a490";
ZSH_PROMPT_K8S="#cdcd9d";
ZSH_PROMPT_ZVM_NORMAL="#5496d4";
ZSH_PROMPT_ZVM_INSERT="#41a490";
ZSH_PROMPT_ZVM_VISUAL="#ce9178";
ZSH_PROMPT_ZVM_REPLACE="#cc5733";
# end colors

NL=$'\n';

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

    prompt_elapsed=" %F{$ZSH_PROMPT_ELAPSED}祥${elapsed}%{$reset_color%}"

    unset timer
  fi

  if [ $node ]; then
    prompt_node=" %F{$ZSH_PROMPT_NODE} ${node:1}%f"
  fi

  if [ $git ]; then
    prompt_git=" %F{$ZSH_PROMPT_GIT}$(git branch | grep '*' | awk '{$1=""; print $0}')%f"
  fi
  
  if [ $k8s ]; then
    prompt_k8s=" %F{$ZSH_PROMPT_K8S}ﴱ ${k8s}%f"
  fi

  RPROMPT="${prompt_elapsed}${prompt_node}${prompt_git}${prompt_k8s}"
}

function make_cursor_as_blinking_block() {
  echo -e -n "\x1b[\x30 q"
}

function make_cursor_as_steady_bar() {
  echo -e -n "\x1b[\x36 q"
}

function _load_prompt() {
  local prompt_path='%F{$ZSH_PROMPT_PATH}%~%b%f'
  local prompt_zvm=''

  case $ZVM_MODE in
    $ZVM_MODE_NORMAL)
      prompt_zvm='%F{0}%K{$ZSH_PROMPT_ZVM_NORMAL}%B NORMAL %b%f%k%F{default}%K{default}'
      make_cursor_as_blinking_block
    ;;
    $ZVM_MODE_INSERT)
      prompt_zvm='%F{0}%K{$ZSH_PROMPT_ZVM_INSERT}%B INSERT %b%f%k%F{default}%K{default}'
      make_cursor_as_steady_bar
    ;;
    $ZVM_MODE_VISUAL)
      prompt_zvm='%F{0}%K{$ZSH_PROMPT_ZVM_VISUAL}%B VISUAL %b%f%k%F{default}%K{default}'
      make_cursor_as_blinking_block
    ;;
    $ZVM_MODE_VISUAL_LINE)
      prompt_zvm='%F{0}%K{$ZSH_PROMPT_ZVM_VISUAL}%B V-LINE %b%f%k%F{default}%K{default}'
      make_cursor_as_blinking_block
    ;;
    $ZVM_MODE_REPLACE)
      prompt_zvm='%F{0}%K{$ZSH_PROMPT_ZVM_REPLACE}%B REPLACE %b%f%k%F{default}%K{default}'
      make_cursor_as_blinking_block
    ;;
  esac

  PROMPT="${prompt_zvm} ${prompt_path} "
}
function zvm_after_select_vi_mode() {
  _load_prompt
}

_load_prompt
