local assets = require('assets')
local nvim_highlight_colors = require('nvim-highlight-colors')

nvim_highlight_colors.setup({
  render = 'virtual',
  virtual_symbol = assets.highlight_color_icons.virtual_symbol,
  virtual_symbol_position = 'eol',
  exclude_filetypes = {
    'csv',
  },
})
