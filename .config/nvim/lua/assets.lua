local kind_icons = {
  Text = '󰉿', -- nf-md-format_size
  -- Method = "m",
  -- Function = "󰊕", -- nf-md-function
  -- Constructor = "", -- nf-cod-tools
  Method = '󰆧', -- nf-md-cube_outline
  Function = '󰆧', -- nf-md-cube_outline
  Constructor = '󰆧', -- nf-md-cube_outline
  Field = '', -- nf-dev-codepen
  Variable = '', -- nf-dev-codepen
  Class = '󰌗', -- nf-md-lan
  Interface = '', -- nf-fa-sitemap
  -- Module = "",
  Module = '󰅩', -- nf-md-code_braces
  Property = '', -- nf-fa-wrench
  Unit = '', -- nf-fae-ruler
  Value = '󰎠', -- nf-md-numeric
  Enum = '', -- nf-fa-arrow_down_a_z
  -- Keyword = "", -- nf-cod-key
  Keyword = '󰉨', -- nf-md-format_float_left
  -- Snippet = "", -- nf-fa-scissors
  Snippet = '󰃐', -- nf-md-border_style
  Color = '󰏘', -- nf-md-palette
  File = '󰈙', -- nf-md-file_document
  Reference = '', -- nf-cod-file_symlink_file
  Folder = '󰉋', -- nf-fa-folder
  EnumMember = '', -- nf-fa-arrow_down_a_z
  Constant = '󰇽', -- nf-md-equal_box
  Struct = '', -- nf-fa-cubes
  Event = '', -- nf-fa-flash
  Operator = '󰆕', -- nf-md-contrast
  TypeParameter = '󰊄', -- nf-md-format_text
}

local diagnostic_icons = {
  error = '', -- nf-cod-error
  warn = '', -- nf-cod-warning
  info = '', -- nf-cod-info
  hint = '', -- nf-oct-light_bulb
}

local git_signs = {
  add = '┃',
  change = '┃',
  delete = '_',
  topdelete = '‾',
  changedelete = '~',
  untracked = '┆',
}

local borders = {
  horisontal = '─',
  vertical = '│',
  top_left_corner = '┌',
  top_right_corner = '┐',
  bottom_left_corner = '└',
  bottom_right_corner = '┘',
}

local border_types = {
  single = 'single',
}

return {
  kind_icons = kind_icons,
  diagnostic_icons = diagnostic_icons,
  git_signs = git_signs,
  borders = borders,
  border_types = border_types,
}
