require("settings")
require("mappings")
require("plugins")

require("lualine-setup")
require("nvim-tree-setup")
require("darkplus-theme-setup")

-- intellisense
require("lspconfig-setup")
require("cmp-setup")

require("telescope-setup")
require("trouble-config")
require("nvim-tresitter-setup")
require("bufferline-setup")

require("indent_blankline").setup {
  -- for example, context is off by default, use this to turn it on
  show_current_context = true,
  show_current_context_start = true,
}

require('colorizer').setup()
require('nvim-autopairs').setup {}
require('Comment').setup()
