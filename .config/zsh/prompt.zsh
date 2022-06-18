# https://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html
# https://gist.github.com/knadh/123bca5cfdae8645db750bfb49cb44b0

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "%{$fg[green]%}%b"
zstyle ':vcs_info:git*' actionformats "%{$fg[green]%}%b %{$fg[red]%}%a"

setopt prompt_subst

function preexec() {
  timer=$(date +%s%3N)
}

function precmd() {
  vcs_info

  if [ $timer ]; then
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

    RPROMPT="%F{#555753}${elapsed} %{$reset_color%}${vcs_info_msg_0_}"
    unset timer
  else
    RPROMPT='${vcs_info_msg_0_}'
  fi
}

PROMPT='%F{yellow}[%F{green}%~%b%f%F{yellow}]%f '
