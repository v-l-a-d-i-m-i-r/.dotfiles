require("settings")
require("mappings")
require("autocommands")
require("plugins")
require("components-plugin")
require("components-setup")

require("lualine-setup")
require("nvim-tree-setup")
require("darkplus-theme-setup")

-- intellisense
require("lspconfig-setup")
require("cmp-setup")

-- Debugger
require("vimspector-setup")
-- require("dap-setup")

require("telescope-setup")
require("trouble-config")
require("nvim-tresitter-setup")
require("bufferline-setup")
require("surround-setup")

require("indent_blankline").setup {
  -- for example, context is off by default, use this to turn it on
  show_current_context = true,
  show_current_context_start = true,
}

require('colorizer').setup()
require('nvim-autopairs').setup {}
require('Comment').setup()

-- TODO:
-- 1. [lspconfig] Unable to find ESLint library.
--    https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
--    https://github.com/neovim/nvim-lspconfig/issues/1310
--
-- 2. Fix warnings :checkhealth
--
-- 3. Quick noh
--
-- 4. Add best dotfiles repos
