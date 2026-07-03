local assets = require('assets')
local ibl = require('ibl')

ibl.setup({
  indent = {
    char = assets.indent.tab,
    smart_indent_cap = false,
  },
})
