# Show available recipes
default:
  @just --list

# Initialize
init:
  @git config core.hooksPath .githooks;

# Format
format:
  @./.bin/pretify-json ./.claude/settings.json
  @make -C .config/nvim format
