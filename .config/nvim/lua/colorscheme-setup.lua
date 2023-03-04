-- local theme = require("themes")
-- local lualine_theme = theme.lualine_theme
-- 
-- theme.setup()
-- 
require('lualine').setup({
  options = {
    section_separators = '',
    component_separators = '',
    theme = {
      normal = {
        a = 'LualineNormalA',
        b = 'LualineNormalB',
        c = 'LualineNormalC',
      },
      visual = {
        a = 'LualineVisualA',
        b = 'LualineVisualB',
        c = 'LualineVisualC',
      },
      replace = {
        a = 'LualineReplaceA',
        b = 'LualineReplaceB',
        c = 'LualineReplaceC',
      },
      insert = {
        a = 'LualineInsertA',
        b = 'LualineInsertB',
        c = 'LualineInsertC',
      },
    },
  },
})

vim.cmd('colorscheme code-dark')
