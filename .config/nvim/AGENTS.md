# AGENTS.md — Neovim Configuration Project

## Development Commands
```bash
# Format Lua code
make format

```

## Conventions
- All plugins pinned to specific commits/tags (reproducible)
- Lua files in `lua/` required from `init.lua` or `components-setup.lua`
- Settings in `settings.lua`, keymaps in `mappings.lua`
- Custom plugins loaded via `c.load_plugin('name')` + `require('setup-file')`

## Components
Every component locates in `./components/<component-name>-<md5 hash>`. When agent needs to check some details about component it can do it searching in component folder
