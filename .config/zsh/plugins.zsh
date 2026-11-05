function _add_plugin() {
  local plugin_name=$(basename $1)
  local plugin_path="${HOME}/.config/zsh/.plugins/${plugin_name}-${2:=master}"

  if [ ! -d "${plugin_path}" ]; then
    git clone --depth 1 --branch "${2}" "${1}.git" "${plugin_path}"
  fi

  source "${plugin_path}/${plugin_name}.plugin.zsh"
  source "${plugin_path}/${plugin_name}.zsh"
}

_add_plugin 'https://github.com/jeffreytse/zsh-vi-mode' 'v0.12.0'
_add_plugin 'https://github.com/zsh-users/zsh-autosuggestions' 'v0.7.1'
_add_plugin 'https://github.com/zsh-users/zsh-syntax-highlighting' '0.8.0'
