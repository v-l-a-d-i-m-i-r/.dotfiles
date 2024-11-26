function _govm_use() {
  local version="$1"

  if [ -z "${version}" ]; then
    version=$(govm list | fzf --reverse | sed 's/^ *//g' | sed 's/ *$//g' | tr -d '\n' )
  fi

  if [ -z "${version}" ]; then
    return
  fi

  if [ ! -d "${GOVM_DIR}/versions/go/${version}/bin" ]; then
    echo "go ${version} is not available";

    return
  fi

  local NEW_PATH=""
  declare -a path_array=(`echo $PATH | sed 's/:/\n/g'`)

  for dir in "${path_array[@]}"; do
    if [[ "$dir" =~ "^${GOVM_DIR}\/versions\/go\/v(.*)\/bin$" ]] ; then
      continue
    fi

    NEW_PATH="${NEW_PATH}:${dir}"
  done

  export PATH="${GOVM_DIR}/versions/go/${version}/bin${NEW_PATH}"
}

function _govm_list () {
  if [ ! -d "${GOVM_DIR}/versions/go" ] && return

  local node_version=$(node -v 2>/dev/null)
  local includes_in_list=false
  local versions=$(ls $GOVM_DIR/versions/node | awk '{print $NF}' | sort -r)
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

function _govm_install () {
  local version="$1"

  # if [ -z "${version}" ]; then
  #   version=$(curl -Ls https://nodejs.org/dist/ | grep '"v' | grep -o '">.*/</' | cut -c 3- | rev | cut -c 4- | rev | fzf --reverse)
  # fi

  if [ -z "${version}" ]; then
    return
  fi

  local output_dir="${GOVM_DIR}/versions/go/${version}"

  if [ -d "${output_dir}" ]; then
    return
  fi

  mkdir -p $output_dir
  # curl -L https://nodejs.org/download/release/${version}/node-${version}-linux-x64.tar.gz | tar -xz --strip-components=1 -C $output_dir
  curl -L https://go.dev/dl/go${version}.${GOVM_ARCH}.tar.gz | tar -xz --strip=1 -C $output_dir
}

function govm () {
  if [ -z "${GOVM_DIR}" ]; then
    echo 'GOVM_DIR not set!'

    return 1
  fi

  case "$1" in
  "use")
    _govm_use $2
  ;;
  "list")
    _govm_list
  ;;
  "install")
    _govm_install $2
  ;;
  esac
}

function _handle_govmrc () {
  if [ ! -f '.govmrc' ]; then
    return
  fi

  local version=$(cat .govmrc)

  govm use $version
}

function chpwd() {
  _handle_govmrc
}

govm use 1.20.2
_handle_govmrc
