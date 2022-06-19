function _nvm_use() {
  local version="$1"
  local NEW_PATH=""
  declare -a path_array=(`echo $PATH | sed 's/:/\n/g'`)

  for dir in "${path_array[@]}"; do
    if [[ "$dir" =~ "^${NVM_DIR}\/versions\/node\/v(.*)\/bin$" ]] ; then
      continue
    fi

    NEW_PATH="${NEW_PATH}:${dir}"
  done

  export PATH="${NVM_DIR}/versions/node/v${version}/bin${NEW_PATH}"
}

function _nvm_list () {
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
  local output_dir="${NVM_DIR}/versions/node/v${version}"

  mkdir -p $output_dir
  curl -L https://nodejs.org/download/release/v${version}/node-v${version}-linux-x64.tar.gz | tar -xz --strip-components=1 -C $output_dir
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
