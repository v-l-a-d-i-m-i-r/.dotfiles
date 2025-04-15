local GOVM_VERSIONS_DIR="${GOVM_DIR}/versions/go"

function _govm_use() {
  local version="$1"

  if [ -z "${version}" ]; then
    version=$(govm list | fzf --reverse | sed 's/^ *//g' | sed 's/ *$//g' | tr -d '\n' )
  fi

  if [ -z "${version}" ]; then
    return
  fi

  if [ ! -d "${GOVM_VERSIONS_DIR}/${version}/bin" ]; then
    echo "go ${version} is not available";

    return
  fi

  local NEW_PATH=""
  declare -a path_array=(`echo $PATH | sed 's/:/\n/g'`)

  for dir in "${path_array[@]}"; do
    if [[ "$dir" =~ "^${GOVM_VERSIONS_DIR}\/v(.*)\/bin$" ]] ; then
      continue
    fi

    NEW_PATH="${NEW_PATH}:${dir}"
  done

  export PATH="${GOVM_VERSIONS_DIR}/${version}/bin${NEW_PATH}"
}

function _govm_list () {
  if [ ! -d "${GOVM_VERSIONS_DIR}" ]; then
    return
  fi

  local go_version=$(go version 2> /dev/null | { read _ _ v _; echo ${v#go}; })
  local includes_in_list=false
  local versions=$(ls $GOVM_DIR/versions/go | awk '{print $NF}' | sort -r)
  local output_list=""
  local separator="|"
  local output_separator="  "

  while read -r version; do
    if [ "$go_version" = "$version" ]; then
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
  #   local page=1;

  #   while : ; do
  #     versions_per_page=$(curl -s "https://api.github.com/repos/golang/go/tags?page=${page}" | jq '.[].name' | sed 's/"go//' | sed 's/"//');
  #     versions_pre_page_length=$(echo "$versions_per_page" | wc -l);
  #     echo $page;
  #     echo $versions_per_page;
  #     echo $versions_pre_page_length;

  #     echo '\n';

  #     if [ -z "${versions_pre_page_length}" ]; then
  #       break;
  #     fi

  #     page=$((page+1));
  #   done

  #   return
  # fi

  if [ -z "${version}" ]; then
    return
  fi

  local output_dir="${GOVM_VERSIONS_DIR}/${version}"

  if [ -d "${output_dir}" ]; then
    return
  fi

  mkdir -p $output_dir

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
