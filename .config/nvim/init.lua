require('globals')
require('settings')
require('mappings')
require('clip')
require('components-setup')
require('autocommands')

require('colorscheme-setup')
require('nvim-tree-setup')
require('lualine-setup')
-- intellisense
require('lspconfig-setup')
require('cmp-setup')

-- Debugger
-- require('dap-setup')

-- Git
require('diffview-setup')
require('conflict-marker-setup')

require('telescope-setup')
require('trouble-config')
require('nvim-treesitter-setup')

require('indent_blankline').setup({
  show_current_context = true,
  show_current_context_start = true,
  char = '▏',
})

require('colorizer').setup()
require('nvim-autopairs').setup({})
require('Comment').setup({
  ignore = '^$',
})
require('todo-comments').setup()
require('gitsigns').setup()
require('aerial-setup')
require('nvim-web-devicons').setup({ color_icons = false })
