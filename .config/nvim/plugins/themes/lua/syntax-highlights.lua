return function (params)
  local c = params.base16_colors

  return {
    Boolean      = { guifg = c.base09, guibg = nil, gui = nil, guisp = nil },
    Character    = { guifg = c.base08, guibg = nil, gui = nil, guisp = nil },
    Comment      = { guifg = c.base03, guibg = nil, gui = nil, guisp = nil },
    Conditional  = { guifg = c.base0E, guibg = nil, gui = nil, guisp = nil },
    Constant     = { guifg = c.base09, guibg = nil, gui = nil, guisp = nil },
    Define       = { guifg = c.base0E, guibg = nil, gui = 'none', guisp = nil },
    Delimiter    = { guifg = c.base0F, guibg = nil, gui = nil, guisp = nil },
    Float        = { guifg = c.base09, guibg = nil, gui = nil, guisp = nil },
    Function     = { guifg = c.base0D, guibg = nil, gui = nil, guisp = nil },
    Identifier   = { guifg = c.base08, guibg = nil, gui = 'none', guisp = nil },
    Include      = { guifg = c.base0D, guibg = nil, gui = nil, guisp = nil },
    Keyword      = { guifg = c.base0E, guibg = nil, gui = nil, guisp = nil },
    Label        = { guifg = c.base0A, guibg = nil, gui = nil, guisp = nil },
    Number       = { guifg = c.base09, guibg = nil, gui = nil, guisp = nil },
    Operator     = { guifg = c.base05, guibg = nil, gui = 'none', guisp = nil },
    PreProc      = { guifg = c.base0A, guibg = nil, gui = nil, guisp = nil },
    Repeat       = { guifg = c.base0A, guibg = nil, gui = nil, guisp = nil },
    Special      = { guifg = c.base0C, guibg = nil, gui = nil, guisp = nil },
    SpecialChar  = { guifg = c.base0F, guibg = nil, gui = nil, guisp = nil },
    Statement    = { guifg = c.base08, guibg = nil, gui = nil, guisp = nil },
    StorageClass = { guifg = c.base0A, guibg = nil, gui = nil, guisp = nil },
    String       = { guifg = c.base0B, guibg = nil, gui = nil, guisp = nil },
    Structure    = { guifg = c.base0E, guibg = nil, gui = nil, guisp = nil },
    Tag          = { guifg = c.base0A, guibg = nil, gui = nil, guisp = nil },
    Todo         = { guifg = c.base0A, guibg = c.base01, gui = nil, guisp = nil },
    Type         = { guifg = c.base0A, guibg = nil, gui = 'none', guisp = nil },
    Typedef      = { guifg = c.base0A, guibg = nil, gui = nil, guisp = nil },
  }
end
