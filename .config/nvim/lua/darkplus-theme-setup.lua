-- https://meyerweb.com/eric/tools/color-blend/#1C1C1C:0000FF:10:hex

vim.cmd('colorscheme darkplus')

vim.api.nvim_set_hl(0, 'DiffAdd', { fg = 'none', bg = '#193119' })
vim.api.nvim_set_hl(0, 'DiffDelete', { fg = 'none', bg = '#311919' })
vim.api.nvim_set_hl(0, 'DiffChange', { fg = 'none', bg = '#191931' })
vim.api.nvim_set_hl(0, 'DiffText', { fg = 'none', bg = '#0F0F83' })

-- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#basic-customisations
vim.api.nvim_set_hl(0, 'Pmenu', { bg = '#262626' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'none', fg = '#808080', strikethrough = true })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'none', fg = '#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { bg = 'none', fg = '#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'none', fg = '#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { bg = 'none', fg = '#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { bg = 'none', fg = '#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'none', fg = '#C586C0' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { bg = 'none', fg = '#C586C0' })
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'none', fg = '#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { bg = 'none', fg = '#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { bg = 'none', fg = '#D4D4D4' })

require('lualine-setup')
