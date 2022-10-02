vim.cmd[[
  let g:gruvbox_contrast_dark='soft'
  let g:gruvbox_invert_selection=0

  colorscheme gruvbox
]]

require('lualine').setup {
  options = {
    section_separators = '',
    component_separators = '',
    theme = "gruvbox_dark",
  },
}
