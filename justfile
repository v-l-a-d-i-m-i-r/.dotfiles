# Show available recipes
default:
  @just --list

# Initialize
init:
  @git config core.hooksPath .githooks;

# Format
format:
  @./.bin/pretify-json ./.claude/settings.json
  @./.bin/pretify-json ./.claude/keybindings.json
  @./.bin/pretify-json ./.copilot/settings.json
  @git ls-files -z '*.md' | xargs -0 npx --yes prettier --write
  @make -C .config/nvim format
