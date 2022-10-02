local groups = require("groups-highlight")
local c = require("colors-definitions").base16_colors
local C = require("colors-definitions").colors

return function()
 return {

  -- TSAnnotation         = { guifg = c.base0F, guibg = nil, gui = 'none', guisp = nil },
  -- TSAttribute          = { guifg = c.base0A, guibg = nil, gui = 'none', guisp = nil },
  -- TSCharacter          = { guifg = c.base08, guibg = nil, gui = 'none', guisp = nil },
  -- TSCharacterSpecial
  -- TSConstMacro         = { guifg = c.base08, guibg = nil, gui = 'none', guisp = nil },
  -- TSDanger
  -- TSDebug
  -- TSDefine
  -- TSDefinition      = { guifg = nil, guibg = nil, gui = 'underline', guisp = c.base04 },
  -- TSDefinitionUsage = { guifg = nil, guibg = nil, gui = 'underline', guisp = c.base04 },
  -- TSEnvironment
  -- TSEnvironmentName
  -- TSMath
  -- TSNote
  -- TSPreProc
  -- TSStringSpecial
  -- TSTagAttribute
  -- TSTextReference
  -- TSTodo
  -- TSWarning
  TSBoolean            = groups.Boolean,
  TSComment            = groups.Comments,
  TSConditional        = groups.Keyword,
  TSConstBuiltin       = groups.Variable,
  TSConstant           = groups.Variable,
  TSConstructor        = groups.Type,
  TSCurrentScope    = { guifg = nil, guibg = nil, gui = 'bold', guisp = nil },
  TSEmphasis           = { guifg = c.base09, guibg = nil, gui = 'italic', guisp = nil },
  TSError              = { guifg = C.red, guibg = nil, gui = 'none', guisp = nil },
  TSException          = groups.Keyword,
  TSField              = groups.Property,
  TSFloat              = groups.Number,
  TSFuncBuiltin        = groups.Function,
  TSFuncMacro          = groups.Function,
  TSFuncionCall        = groups.Function,
  TSFunction           = groups.Function,
  TSInclude            = groups.Keyword,
  TSKeyword            = groups.Keyword,
  TSKeywordFunction    = groups.Keyword,
  TSKeywordOperator    = groups.Keyword,
  TSKeywordReturn      = groups.Keyword,
  TSLabel              = { guifg = c.base0A, guibg = nil, gui = 'none', guisp = nil },
  TSLiteral            = { guifg = c.base09, guibg = nil, gui = 'none', guisp = nil },
  TSMethod             = groups.Function,
  TSMethodCall         = groups.Function,
  TSNamespace          = { guifg = c.base08, guibg = nil, gui = 'none', guisp = nil },
  TSNone               = { guifg = c.base05, guibg = nil, gui = 'none', guisp = nil },
  TSNumber             = groups.Number,
  TSOperator           = groups.Punctuation,
  TSParameter          = groups.Variable,
  TSParameterReference = groups.Property,
  TSProperty           = groups.Property,
  TSPunctBracket       = groups.Punctuation,
  TSPunctDelimiter     = groups.Punctuation,
  TSPunctSpecial       = groups.Punctuation,
  TSRepeat             = groups.Keyword,
  TSStrike             = { guifg = c.base00, guibg = nil, gui = 'strikethrough', guisp = nil },
  TSString             = groups.String,
  TSStringEscape       = { guifg = C.yellow, guibg = nil, gui = 'none', guisp = nil },
  TSStringRegex        = { guifg = C.green, guibg = nil, gui = 'none', guisp = nil },
  TSStrong             = { guifg = nil, guibg = nil, gui = 'bold', guisp = nil },
  TSSymbol             = { guifg = c.base0B, guibg = nil, gui = 'none', guisp = nil },
  TSTag                = { guifg = c.base0A, guibg = nil, gui = 'none', guisp = nil },
  TSTagDelimiter       = { guifg = c.base0F, guibg = nil, gui = 'none', guisp = nil },
  TSText               = { guifg = c.base05, guibg = nil, gui = 'none', guisp = nil },
  TSTitle              = { guifg = c.base0D, guibg = nil, gui = 'none', guisp = nil },
  TSType               = groups.Type,
  TSTypeBuiltin        = groups.Type,
  TSTypeDefinition     = groups.Type,
  TSTypeQualifier      = groups.Type,
  TSURI                = { guifg = c.base09, guibg = nil, gui = 'underline', guisp = nil },
  TSUnderline          = { guifg = c.base00, guibg = nil, gui = 'underline', guisp = nil },
  TSVariable           = groups.Variable,
  TSVariableBuiltin    = { guifg = C.green, guibg = nil, gui = 'none', guisp = nil }, }
end
