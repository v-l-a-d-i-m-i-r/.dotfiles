bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

source ~/.zshenv
if [ -f ~/.config/zsh/private-env.zsh ]; then
  source ~/.config/zsh/private-env.zsh
fi
source ~/.config/zsh/nvm.zsh
source ~/.config/zsh/completion.zsh
source ~/.config/zsh/fzf.zsh
# source ~/.config/zsh/govm.zsh
source ~/.config/zsh/plugins.zsh
source ~/.config/zsh/prompt.zsh
source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/mpv.zsh
source ~/.config/zsh/nvim.zsh

if [ -z "${TMUX}" ]; then
  tsh;
fi
