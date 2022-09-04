# https://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html
# https://gist.github.com/knadh/123bca5cfdae8645db750bfb49cb44b0

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "%F{green} %b%f"
zstyle ':vcs_info:git*' actionformats "%F{green} %b%f %F{red}%a%f"

setopt prompt_subst

function preexec() {
  timer=$(date +%s%3N)
  vcs_info
}

function precmd() {
  vcs_info
  local node=$(node -v 2> /dev/null)

  local prompt_elapsed
  local prompt_git=" ${vcs_info_msg_0_}"
  local prompt_node

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

    prompt_elapsed=" %F{#555753}祥${elapsed}%{$reset_color%}"

    unset timer
  fi

  if [ $node ]; then
    prompt_node=" %F{#5497CF} ${node:1}%f"
  fi

  RPROMPT="${prompt_elapsed}${prompt_node}${prompt_git}"
}
function _load_prompt() {
  local prompt_path='%F{yellow}%~%b%f'
  local prompt_zvm=''

  case $ZVM_MODE in
    $ZVM_MODE_NORMAL)
      prompt_zvm='%F{#262626}%K{#608B4E}%B NORMAL %b%f%k%F{default}%K{default}'
    ;;
    $ZVM_MODE_INSERT)
      prompt_zvm='%F{#262626}%K{#569CD6}%B INSERT %b%f%k%F{default}%K{default}'
    ;;
    $ZVM_MODE_VISUAL)
      prompt_zvm='%F{#262626}%K{#C586C0}%B VISUAL %b%f%k%F{default}%K{default}'
    ;;
    $ZVM_MODE_VISUAL_LINE)
      prompt_zvm='%F{#262626}%K{#C586C0}%B V-LINE %b%f%k%F{default}%K{default}'
    ;;
    $ZVM_MODE_REPLACE)
      prompt_zvm='%F{#262626}%K{#D16969}%B REPLACE %b%f%k%F{default}%K{default}'
    ;;
  esac

  PROMPT="${prompt_zvm} ${prompt_path} "
}
function zvm_after_select_vi_mode() {
  _load_prompt
}

_load_prompt
