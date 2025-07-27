local kind_icons = {
  Text = '',
  -- Method = "m",
  -- Function = "",
  -- Constructor = "",
  Method = '',
  Function = '',
  Constructor = '',
  Field = '',
  -- Variable = "",
  Variable = '',
  Class = '',
  Interface = '',
  -- Module = "",
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '',
  -- Keyword = "",
  Keyword = '',
  -- Snippet = "",
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
}

local diagnostic_icons = {
  error = '',
  warn = '',
  info = '',
  hint = '',
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
