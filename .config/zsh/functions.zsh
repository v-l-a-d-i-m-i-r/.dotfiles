function add_plugin() {
  local plugin_name=$(basename $1)
  local plugin_path="${HOME}/.config/zsh/plugins/${plugin_name}-${2:=master}"

  if [ -d "${plugin_path}" ]; then
    source "${plugin_path}/${plugin_name}.plugin.zsh"
    source "${plugin_path}/${plugin_name}.zsh"
  else
    git clone --depth 1 --branch "${2}" "https://github.com/${1}.git" "${plugin_path}"
  fi
}
