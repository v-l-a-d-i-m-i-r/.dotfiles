local c = require("colors-definitions").base16_colors
local C = require("colors-definitions").colors
local groups = require("groups-highlight")

return function ()
  return {
		-- Debug = {fg = C.red, },
		-- Error = {fg = C.error_red, bg = C.bg, style = "bold", },
		-- Exception = {fg = C.purple, },
		-- Identifier = {fg = C.light_blue, },
		-- Ignore = {fg = C.cyan, bg = C.bg, style = "bold", },
		-- Italic = {style = "italic", },
		-- Macro = {fg = C.purple, },
		-- PreCondit = {fg = C.purple, },
		-- PreProc = {fg = C.purple, },
		-- Special = {fg = C.orange, },
		-- SpecialChar = {fg = C.white, },
		-- SpecialComment = {fg = C.gray, },
		-- Statement = {fg = C.purple, },
		-- StorageClass = {fg = C.blue, },
		-- String = {fg = C.orange, },
		-- Structure = {fg = C.blue, },
		-- TabLine = {fg = C.light_gray, bg = C.alt_bg, },
		-- TabLineFill = {fg = C.alt_bg, bg = C.alt_bg, },
		-- TabLineSel = {fg = C.white, bg = C.alt_bg, },
		-- Typedef = {fg = C.blue, },
		-- Underlined = {style = "underline", },
    Boolean      = groups.Boolean,
    Character    = groups.String,
    Comment      = groups.Comments,
    Conditional  = groups.Keyword,
    Constant     = groups.Variable,
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
    SpecialChar  = { guifg = C.pink, guibg = nil, gui = nil, guisp = nil },
    Statement    = { guifg = C.purple, guibg = nil, gui = nil, guisp = nil },
    StorageClass = { guifg = C.yellow, guibg = nil, gui = nil, guisp = nil },
    String       = groups.String,
    Structure    = groups.Type,
    Tag          = { guifg = C.blue, guibg = nil, gui = nil, guisp = nil },
    Todo         = { guifg = C.blue, guibg = C.bg_secondary, gui = nil, guisp = nil },
    Type         = groups.Type,
    Typedef      = groups.Type,
		Variable = groups.Variable,
  }
end
