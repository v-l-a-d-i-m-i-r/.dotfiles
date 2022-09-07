setopt HIST_IGNORE_ALL_DUPS

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=10000000

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#797979'

export NVM_DIR="$HOME/.nvm"
export EDITOR="nvim"
export KUBE_EDITOR="nvim"
export MANPAGER="nvim +Man!"
export ZVM_CURSOR_STYLE_ENABLED=false

export PATH="$HOME/.cache/activestate/bin:$PATH"
export PATH="$HOME/.bin/:$PATH"
export PATH="/usr/lib/ccache/bin/:$PATH"
# export XDG_SESSION_TYPE="X11"
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1

export LD_LIBRARY_PATH="/data/projects/sf-platform/repos/sf-backend/packages/backend"

export LIBGL_DRI3_DISABLE=1

# https://github.com/nodkz/mongodb-memory-server#options-which-can-be-set-via-environment-variables
export MONGOMS_SYSTEM_BINARY="/data/projects/flip/flip-platform/mongodb-binaries/mongod-5.0.8"
export MONGOMS_DISABLE_POSTINSTALL="1"

# export MONGOMS_DEBUG="1"
# export MONGOMS_PLATFORM="linux"
# export MONGOMS_ARCH="x64"
# export MONGOMS_USE_LINUX_LSB_RELEASE="0"
# export MONGOMS_USE_LINUX_OS_RELEASE="0"
# export MONGOMS_USE_LINUX_ANYFILE_RELEASE="0"
