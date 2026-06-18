# https://github.com/google-gemini/gemini-cli
gemini() {
  if [ -z "$GEMINI_CLI_NODE_VERSION" ]; then
    echo 'Error: GEMINI_CLI_NODE_VERSION is not set.';
    return 1;
  fi

  cp ${HOME}/.agents/AGENTS.md ${HOME}/.gemini/GEMINI.md;

  zsh -ci '
    set -e;
    nvm use ${GEMINI_CLI_NODE_VERSION};
    $NVM_DIR/versions/node/${GEMINI_CLI_NODE_VERSION}/bin/gemini $@;
  ' -- "$@";
}

# https://github.com/github/copilot-cli
copilot() {
  if [ -z "$COPILOT_CLI_NODE_VERSION" ]; then
    echo 'Error: COPILOT_CLI_NODE_VERSION is not set.';
    return 1;
  fi

  cp ${HOME}/.agents/AGENTS.md ${HOME}/.copilot/copilot-instructions.md;

  zsh -ci '
    set -e;
    nvm use ${COPILOT_CLI_NODE_VERSION};
    $NVM_DIR/versions/node/${COPILOT_CLI_NODE_VERSION}/bin/copilot $@;
  ' -- "$@";
}

copilot-ralph() {
  # https://docs.github.com/en/copilot/how-tos/copilot-cli/set-up-copilot-cli/configure-copilot-cli
  copilot \
    --allow-all-tools \
    --allow-all-paths \
    --deny-tool='shell(rm)' \
    --deny-tool='shell(git push)' \
    --silent \
    $@;
}

# https://github.com/openai/codex
codex() {
  if [ -z "$CODEX_CLI_NODE_VERSION" ]; then
    echo 'Error: CODEX_CLI_NODE_VERSION is not set.';
    return 1;
  fi

  cp ${HOME}/.agents/AGENTS.md ${HOME}/.codex/AGENTS.md;

  zsh -ci '
    set -e;
    nvm use ${CODEX_CLI_NODE_VERSION};
    $NVM_DIR/versions/node/${CODEX_CLI_NODE_VERSION}/bin/codex $@;
  ' -- "$@";
}

codex-update() {
  if [ -z "$CODEX_CLI_NODE_VERSION" ]; then
    echo 'Error: CODEX_CLI_NODE_VERSION is not set.';
    return 1;
  fi

  zsh -ci '
    set -e;
    nvm use ${CODEX_CLI_NODE_VERSION};
    npm install -g @openai/codex;
  ' -- "$@";
}

# https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent
pi() {
  if [ -z "$PI_CLI_NODE_VERSION" ]; then
    echo 'Error: PI_CLI_NODE_VERSION is not set.';
    return 1;
  fi

  cp ${HOME}/.agents/AGENTS.md ${HOME}/.pi/agent/AGENTS.md

  zsh -ci '
    set -e;
    nvm use ${PI_CLI_NODE_VERSION};
    $NVM_DIR/versions/node/${PI_CLI_NODE_VERSION}/bin/pi $@;
  ' -- "$@";
}

# https://github.com/QwenLM/qwen-code
qwen() {
  if [ -z "$QWEN_CLI_NODE_VERSION" ]; then
    echo 'Error: QWEN_CLI_NODE_VERSION is not set.';
    return 1;
  fi

  cp ${HOME}/.agents/AGENTS.md ${HOME}/.qwen/QWEN.md;

  local args=(
    # https://github.com/QwenLM/qwen-code/issues/494
    "--prompt-interactive='Read instructions @~/.qwen/QWEN.md and follow them for the future'"
  );
  local subshell_script=$(cat <<EOF
    set -e;
    nvm use ${QWEN_CLI_NODE_VERSION};
    $NVM_DIR/versions/node/${QWEN_CLI_NODE_VERSION}/bin/qwen ${args[@]} $@;
EOF
  );

  zsh -ci "$subshell_script";
}
