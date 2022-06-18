export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=10000000
setopt HIST_IGNORE_ALL_DUPS

export KUBE_EDITOR="nvim"

export PATH="$HOME/.bin/:/snap/bin:/usr/lib/ccache/bin/:$PATH"
# export XDG_SESSION_TYPE="X11"
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1

export LD_LIBRARY_PATH="/data/projects/sf-platform/repos/sf-backend/packages/backend"

# https://github.com/nodkz/mongodb-memory-server#options-which-can-be-set-via-environment-variables
export MONGOMS_SYSTEM_BINARY="/usr/bin/mongod"
export MONGOMS_DISABLE_POSTINSTALL="1"
# export MONGOMS_DEBUG="1"
# export MONGOMS_PLATFORM="linux"
# export MONGOMS_ARCH="x64"
# export MONGOMS_USE_LINUX_LSB_RELEASE="0"
# export MONGOMS_USE_LINUX_OS_RELEASE="0"
# export MONGOMS_USE_LINUX_ANYFILE_RELEASE="0"
export PYTHON="python2"
