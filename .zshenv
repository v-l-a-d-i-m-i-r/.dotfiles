setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=10000000

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#797979'

export NVIM_APPNAME='nvim' # config folder
export NVIM_VERSION='0.11.5'
export NVIM_ARCH='linux-x86_64'
export NVIM_DIR="$HOME/.config/$NVIM_APPNAME/.editors/$NVIM_VERSION"
export NVIM_PATH="$NVIM_DIR/bin/nvim"

export NVM_DIR="$HOME/.nvm"
export NVM_ARCH="linux-x64"
export GOVM_DIR="$HOME/.govm"
export GOVM_ARCH="linux-amd64"
export EDITOR="$NVIM_PATH"
export KUBE_EDITOR="$NVIM_PATH"
export MANPAGER="$NVIM_PATH +Man!"
export ZVM_CURSOR_STYLE_ENABLED=false

export PATH="$HOME/.cache/activestate/bin:$PATH"
export PATH="$HOME/.bin/:$PATH"
export PATH="/usr/lib/ccache/bin/:$PATH"
# export XDG_SESSION_TYPE="X11"
export DOCKER_OPTS="--dns=8.8.8.8"
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1
export BUILDKIT_PROGRESS=plain

export LD_LIBRARY_PATH="/data/projects/sf-platform/repos/sf-backend/packages/backend"

export LIBGL_DRI3_DISABLE=1

# https://github.com/nodkz/mongodb-memory-server#options-which-can-be-set-via-environment-variables
export MONGOMS_SYSTEM_BINARY="/home/vladimir/mongod-5.0.8"
export MONGOMS_DISABLE_POSTINSTALL="1"

# export MONGOMS_DEBUG="1"
# export MONGOMS_PLATFORM="linux"
# export MONGOMS_ARCH="x64"
# export MONGOMS_USE_LINUX_LSB_RELEASE="0"
# export MONGOMS_USE_LINUX_OS_RELEASE="0"
# export MONGOMS_USE_LINUX_ANYFILE_RELEASE="0"
export GOBIN=$(which go)
export GO111MODULE=on

export BROWSER="$HOME/.bin/url-logger"

export AZCOPY_AUTO_LOGIN_TYPE=AZCLI
