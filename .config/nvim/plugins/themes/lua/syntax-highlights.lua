return function (params)
  local C  = params.colors
  local groups = params.groups
  return {
		-- Ignore = {fg = C.cyan, bg = C.bg, style = "bold", },
		-- Macro = {fg = C.purple, },
		-- PreCondit = {fg = C.purple, },
		-- PreProc = {fg = C.purple, },
		-- SpecialComment = {fg = C.gray, },
    Boolean      = groups.Boolean,
    Character    = groups.String,
    Comment      = groups.Comments,
    Conditional  = groups.Keyword,
    Constant     = groups.Variable,
    Error        = groups.Error,
    Define       = { guifg = C.purple, guibg = nil, gui = 'none', guisp = nil },
    Delimiter    = groups.Punctuation,
    Float        = groups.Number,
    Function     = groups.Function,
    Identifier   = groups.Keyword,
    Include      = groups.Keyword,
    Keyword      = groups.Keyword,
    Label        = { guifg = C.purple, guibg = nil, gui = nil, guisp = nil },
    Number       = groups.Number,
    Operator     = groups.Punctuation,
    PreProc      = { guifg = C.yellow, guibg = nil, gui = nil, guisp = nil },
    Repeat       = groups.Keyword,
    Special      = { guifg = C.orange, guibg = nil, gui = nil, guisp = nil },
    SpecialChar  = { guifg = C.fg_tertiary, guibg = nil, gui = nil, guisp = nil },
    Statement    = { guifg = C.purple, guibg = nil, gui = nil, guisp = nil },
    StorageClass = { guifg = C.blue, guibg = nil, gui = nil, guisp = nil },
    String       = groups.String,
    Structure    = groups.Type,
    Tag          = groups.Tag,
    Todo         = { guifg = C.blue, guibg = C.bg_secondary, gui = nil, guisp = nil },
    Type         = groups.Type,
    Typedef      = groups.Type,
		Variable = groups.Variable,
  }
end
