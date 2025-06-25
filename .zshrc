bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

source ~/.zshenv
if [ -f ~/.config/zsh/private-env.zsh ]; then
  source ~/.config/zsh/private-env.zsh
fi
source ~/.config/zsh/nvm.zsh
source ~/.config/zsh/completion.zsh
source ~/.config/zsh/fzf.zsh
source ~/.config/zsh/govm.zsh
source ~/.config/zsh/prompt.zsh
source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/mpv.zsh

# zsh plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

if [ -z "${TMUX}" ] && [ ! -z "${DISPLAY}" ]; then
  tsh;
fi
