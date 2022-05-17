# https://unix.stackexchange.com/questions/450043/overwrite-and-reuse-existing-function-in-zsh

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

function load_nvm {
  # Don't try to load nvm if command already available
  # Note: nvm_original is a function so we need to use `which`
  ! which nvm_original &>/dev/null || return

  functions[nvm_wrapper]=$functions[nvm] 

  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

  functions[nvm_original]=$functions[nvm]
  functions[nvm]=$functions[nvm_wrapper] 
}

function nvm {
  list="use"

  load_nvm;
  nvm_original "$@"

  # if [ "$1" == "use" ]; then
    export NODE_PATH=$(realpath $(dirname $(which node))/../lib/node_modules);
  # fi
}

function node npm yarn {
  unfunction node npm yarn

  load_nvm;
  nvm use default > /dev/null

  command "$0" "$@"
}

