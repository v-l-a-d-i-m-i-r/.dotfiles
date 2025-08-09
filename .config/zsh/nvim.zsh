function _download_nvim_if_not_exists() {
  if [ ! -f "${NVIM_PATH}" ]; then
    echo "Downloading nvim v${NVIM_VERSION} into ${NVIM_DIR}";
    local url="https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-${NVIM_ARCH}.tar.gz";

    mkdir -p "${NVIM_DIR}";
    curl -sL "${url}" | tar -xzf - -C "${NVIM_DIR}" --strip-components=1;
  fi
}

_download_nvim_if_not_exists;
