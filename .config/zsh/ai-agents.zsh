# https://github.com/google-gemini/gemini-cli
gemini() {
  if [ -z "$GEMINI_CLI_NODE_VERSION" ]; then
    echo 'Error: GEMINI_CLI_NODE_VERSION is not set.';
    return 1;
  fi

  cp ${HOME}/.agents/AGENTS.md ${HOME}/.gemini/GEMINI.md;

  PATH="$NVM_DIR/versions/node/${GEMINI_CLI_NODE_VERSION}/bin:$PATH" \
    "$NVM_DIR/versions/node/${GEMINI_CLI_NODE_VERSION}/bin/gemini" "$@"
}

# https://github.com/github/copilot-cli
copilot() {
  if [ -z "$COPILOT_CLI_NODE_VERSION" ]; then
    echo 'Error: COPILOT_CLI_NODE_VERSION is not set.';
    return 1;
  fi

  cp ${HOME}/.agents/AGENTS.md ${HOME}/.copilot/copilot-instructions.md;

  PATH="$NVM_DIR/versions/node/${COPILOT_CLI_NODE_VERSION}/bin:$PATH" \
    "$NVM_DIR/versions/node/${COPILOT_CLI_NODE_VERSION}/bin/copilot" "$@"
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

  PATH="$NVM_DIR/versions/node/${CODEX_CLI_NODE_VERSION}/bin:$PATH" \
    "$NVM_DIR/versions/node/${CODEX_CLI_NODE_VERSION}/bin/codex" "$@"
}

# https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent
pi() {
  if [ -z "$PI_CLI_NODE_VERSION" ]; then
    echo 'Error: PI_CLI_NODE_VERSION is not set.';
    return 1;
  fi

  cp ${HOME}/.agents/AGENTS.md ${HOME}/.pi/agent/AGENTS.md

  PATH="$NVM_DIR/versions/node/${PI_CLI_NODE_VERSION}/bin:$PATH" \
    "$NVM_DIR/versions/node/${PI_CLI_NODE_VERSION}/bin/pi" "$@"
}

pi-ralph() {
  if [ -z "$PI_CLI_NODE_VERSION" ]; then
    echo 'Error: PI_CLI_NODE_VERSION is not set.';
    return 1;
  fi

  cp ${HOME}/.agents/AGENTS.md ${HOME}/.pi/agent/AGENTS.md

  # devstral-latest
  PATH="$NVM_DIR/versions/node/${PI_CLI_NODE_VERSION}/bin:$PATH" \
    "$NVM_DIR/versions/node/${PI_CLI_NODE_VERSION}/bin/pi" "$@"
}

# https://github.com/QwenLM/qwen-code
qwen() {
  if [ -z "$QWEN_CLI_NODE_VERSION" ]; then
    echo 'Error: QWEN_CLI_NODE_VERSION is not set.';
    return 1;
  fi

  cp ${HOME}/.agents/AGENTS.md ${HOME}/.qwen/QWEN.md;

  # https://github.com/QwenLM/qwen-code/issues/494
  PATH="$NVM_DIR/versions/node/${QWEN_CLI_NODE_VERSION}/bin:$PATH" \
    "$NVM_DIR/versions/node/${QWEN_CLI_NODE_VERSION}/bin/qwen" \
    --prompt-interactive='Read instructions @~/.qwen/QWEN.md and follow them for the future' \
    "$@"
}

opencode-install() {
  if [ -z "$OPENCODE_CLI_NODE_VERSION" ]; then
    echo 'Error: OPENCODE_CLI_NODE_VERSION is not set.';
    return 1;
  fi

  PATH="$NVM_DIR/versions/node/${OPENCODE_CLI_NODE_VERSION}/bin:$PATH" \
    "$NVM_DIR/versions/node/${OPENCODE_CLI_NODE_VERSION}/bin/npm" i -g opencode-ai
}

opencode() {
  if [ -z "$OPENCODE_CLI_NODE_VERSION" ]; then
    echo 'Error: OPENCODE_CLI_NODE_VERSION is not set.';
    return 1;
  fi

  PATH="$NVM_DIR/versions/node/${OPENCODE_CLI_NODE_VERSION}/bin:$PATH" \
    "$NVM_DIR/versions/node/${OPENCODE_CLI_NODE_VERSION}/bin/opencode" "$@"
}

vibe() {
  cp ${HOME}/.agents/AGENTS.md ${HOME}/.vibe/AGENTS.md

  ${HOME}/.local/bin/vibe $@;
}

vibe-ralph() {
  cp ${HOME}/.agents/AGENTS.md ${HOME}/.vibe/AGENTS.md

  # ignores cofig from $VIBE_HOME/config.toml
  # VIBE_HOME="${HOME}/.vibe-ralph" \
  ${HOME}/.local/bin/vibe \
    --trust \
    $@;
}

claude() {
  cp ${HOME}/.agents/AGENTS.md ${HOME}/.claude/CLAUDE.md;
  rsync -a --delete "${HOME}/.agents/skills/" "${HOME}/.claude/skills/";

  ${HOME}/.local/bin/claude;
}
