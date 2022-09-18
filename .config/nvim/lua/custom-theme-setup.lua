local theme = require("themes")
local lualine_theme = theme.lualine_theme

theme.setup()

require('lualine').setup({
  options = {
    section_separators = '',
    component_separators = '',
    theme = lualine_theme,
  },
})
