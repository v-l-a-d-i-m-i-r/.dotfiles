function _nvm_use() {
  local version="$1"

  if [ -z "${version}" ]; then
    version=$(nvm list | fzf --reverse | sed 's/^ *//g' | sed 's/ *$//g' | tr -d '\n' )
  fi

  if [ -z "${version}" ]; then
    return
  fi

  if [ ! -d "${NVM_DIR}/versions/node/${version}/bin" ]; then
    echo "node ${version} is not available";

    return
  fi

  local NEW_PATH=""
  declare -a path_array=(`echo $PATH | sed 's/:/\n/g'`)

  for dir in "${path_array[@]}"; do
    if [[ "$dir" =~ "^${NVM_DIR}\/versions\/node\/v(.*)\/bin$" ]] ; then
      continue
    fi

    NEW_PATH="${NEW_PATH}:${dir}"
  done

  export PATH="${NVM_DIR}/versions/node/${version}/bin${NEW_PATH}"
}

function _nvm_list () {
  if [ ! -d "${NVM_DIR}/versions/node" ] && return

  local node_version=$(node -v 2>/dev/null)
  local includes_in_list=false
  local versions=$(ls $NVM_DIR/versions/node | awk '{print $NF}' | sort -r)
  local output_list=""
  local separator="|"
  local output_separator="  "

  while read -r version; do
    if [ "$node_version" = "$version" ]; then
      output_list="$output_list*$separator$version$separator\n"

      continue
    fi

    output_list="$output_list$separator$version$separator\n"
  done <<< "$versions"

  echo -e $output_list | column --table --separator $separator --output-separator $output_separator;
}

function _nvm_install () {
  local version="$1"

  if [ -z "${version}" ]; then
    version=$(curl -Ls https://nodejs.org/dist/ | grep '"v' | grep -o '">.*/</' | cut -c 3- | rev | cut -c 4- | rev | fzf --reverse)
  fi

  if [ -z "${version}" ]; then
    return
  fi

  local output_dir="${NVM_DIR}/versions/node/${version}"

  if [ -d "${output_dir}" ]; then
    return
  fi

  mkdir -p $output_dir
  curl -L https://nodejs.org/download/release/${version}/node-${version}-${NVM_ARCH}.tar.gz | tar -xz --strip-components=1 -C $output_dir
}

function nvm () {
  if [ -z "${NVM_DIR}" ]; then
    echo 'NVM_DIR not set!'

    return 1
  fi

  case "$1" in
  "use")
    _nvm_use $2
  ;;
  "list")
    _nvm_list
  ;;
  "install")
    _nvm_install $2
  ;;
  esac
}

function _handle_nvmrc () {
  if [ ! -f '.nvmrc' ]; then
    return
  fi

  local node_version=$(cat .nvmrc)

  if [[ $node_version == '16' ]]; then
    nvm use 'v16.20.2'
    return
  fi
  if [[ $node_version == '18' ]]; then
    nvm use 'v18.17.1'
    return
  fi
  if [[ $node_version == '14' ]]; then
    nvm use 'v14.19.2'
    return
  fi

  if [[ $node_version == v* ]]; then
    nvm use $node_version
  else
    nvm use "v$node_version"
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _handle_nvmrc

nvm use v14.19.2
_handle_nvmrc
