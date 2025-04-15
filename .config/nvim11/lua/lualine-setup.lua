local tab_width = vim.opt.tabstop
local spaces_indicator = function()
  if vim.bo.expandtab then
    return 'spaces:' .. tab_width
  else
    return 'tabs'
  end
end

local lualine_setup_params = {
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
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'diagnostics' },
    lualine_c = {
      {
        'filename',
        path = 1,
      },
    },
    lualine_x = { 'encoding', 'fileformat', 'filetype', spaces_indicator },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
}

require('lualine').setup(lualine_setup_params)
