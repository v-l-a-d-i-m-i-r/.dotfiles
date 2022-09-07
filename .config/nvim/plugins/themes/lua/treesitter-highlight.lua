local groups = require("groups-highlight")

return function(params)
  local c = params.base16_colors

 return {
  TSAnnotation         = { guifg = c.base0F, guibg = nil, gui = 'none', guisp = nil },
  TSAttribute          = { guifg = c.base0A, guibg = nil, gui = 'none', guisp = nil },
  TSBoolean            = { guifg = c.base09, guibg = nil, gui = 'none', guisp = nil },
  TSCharacter          = { guifg = c.base08, guibg = nil, gui = 'none', guisp = nil },
  -- TSCharacterSpecial
  TSComment            = { guifg = c.base03, guibg = nil, gui = 'italic', guisp = nil },
  TSConditional        = groups.Keyword,
  TSConstant           = groups.Variable,
  TSConstBuiltin       = groups.Variable,
  TSConstMacro         = { guifg = c.base08, guibg = nil, gui = 'none', guisp = nil },
  TSConstructor        = groups.Type,
  -- TSDebug
  -- TSDefine
  TSError              = { guifg = c.base08, guibg = nil, gui = 'none', guisp = nil },
  TSException          = groups.Keyword,
  TSField              = { guifg = c.base05, guibg = nil, gui = 'none', guisp = nil },
  TSFloat              = { guifg = c.base09, guibg = nil, gui = 'none', guisp = nil },
  TSFunction           = groups.Function,
  TSFuncionCall        = groups.Function,
  TSFuncBuiltin        = groups.Function,
  TSFuncMacro          = groups.Function,
  TSInclude            = groups.Keyword,
  TSKeyword            = groups.Keyword,
  TSKeywordFunction    = groups.Keyword,
  TSKeywordOperator    = groups.Keyword,
  TSKeywordReturn      = groups.Keyword,
  TSLabel              = { guifg = c.base0A, guibg = nil, gui = 'none', guisp = nil },
  TSMethod             = groups.Function,
  TSMethodCall         = groups.Function,
  TSNamespace          = { guifg = c.base08, guibg = nil, gui = 'none', guisp = nil },
  TSNone               = { guifg = c.base05, guibg = nil, gui = 'none', guisp = nil },
  TSNumber             = { guifg = c.base09, guibg = nil, gui = 'none', guisp = nil },
  TSOperator           = groups.Punctuation,
  TSParameter          = groups.Variable,
  TSParameterReference = { guifg = c.base05, guibg = nil, gui = 'none', guisp = nil },
  -- TSPreProc
  TSProperty           = { guifg = c.base05, guibg = nil, gui = 'none', guisp = nil },
  TSPunctDelimiter     = groups.Punctuation,
  TSPunctBracket       = groups.Punctuation,
  TSPunctSpecial       = groups.Punctuation,
  TSRepeat             = groups.Keyword,
  TSString             = groups.String,
  TSStringRegex        = { guifg = c.base0C, guibg = nil, gui = 'none', guisp = nil },
  TSStringEscape       = { guifg = c.base0C, guibg = nil, gui = 'none', guisp = nil },
  -- TSStringSpecial
  TSSymbol             = { guifg = c.base0B, guibg = nil, gui = 'none', guisp = nil },
  TSTag                = { guifg = c.base0A, guibg = nil, gui = 'none', guisp = nil },
  -- TSTagAttribute
  TSTagDelimiter       = { guifg = c.base0F, guibg = nil, gui = 'none', guisp = nil },
  TSText               = { guifg = c.base05, guibg = nil, gui = 'none', guisp = nil },
  TSStrong             = { guifg = nil, guibg = nil, gui = 'bold', guisp = nil },
  TSEmphasis           = { guifg = c.base09, guibg = nil, gui = 'italic', guisp = nil },
  TSUnderline          = { guifg = c.base00, guibg = nil, gui = 'underline', guisp = nil },
  TSStrike             = { guifg = c.base00, guibg = nil, gui = 'strikethrough', guisp = nil },
  TSTitle              = { guifg = c.base0D, guibg = nil, gui = 'none', guisp = nil },
  TSLiteral            = { guifg = c.base09, guibg = nil, gui = 'none', guisp = nil },
  TSURI                = { guifg = c.base09, guibg = nil, gui = 'underline', guisp = nil },
  -- TSMath
  -- TSTextReference
  -- TSEnvironment
  -- TSEnvironmentName
  -- TSNote
  -- TSWarning
  -- TSDanger
  -- TSTodo
  TSType               = groups.Type,
  TSTypeBuiltin        = groups.Type,
  TSTypeQualifier      = groups.Type,
  TSTypeDefinition     = groups.Type,
  TSVariable           = groups.Variable,
  TSVariableBuiltin    = groups.Variable,

  TSDefinition      = { guifg = nil, guibg = nil, gui = 'underline', guisp = c.base04 },
  TSDefinitionUsage = { guifg = nil, guibg = nil, gui = 'underline', guisp = c.base04 },
  TSCurrentScope    = { guifg = nil, guibg = nil, gui = 'bold', guisp = nil },
 }
end
