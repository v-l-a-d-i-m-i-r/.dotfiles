local groups = require("groups-highlight")
local C = require("colors-definitions").colors

local function capitalize(s)
	return string.upper(string.sub(s, 1, 1)) .. string.sub(s, 2)
end

-- https://github.com/folke/tokyonight.nvim/blob/v1.0.0/lua/tokyonight/treesitter.lua
local function mapKeyToLegacy(key)
  local hashMap = {
    ["@constant.builtin"] = "TSConstBuiltin",
    ["@constant.macro"] = "TSConstMacro",
    ["@function.builtin"] = "TSFuncBuiltin",
    ["@function.macro"] = "TSFuncMacro",
    ["@preproc"] = "TSPreProc",
    ["@punctuation.bracket"] = "TSPunctBracket",
    ["@punctuation.delimiter"] = "TSPunctDelimiter",
    ["@punctuation.special"] = "TSPunctSpecial",
    ["@storageclass"] = "TSStorageClass",
    ["@text.danger"] = "TSDanger",
    ["@text.emphasis"] = "TSEmphasis",
    ["@text.environment"] = "TSEnvironment",
    ["@text.environment.name"] = "TSEnvironmentName",
    ["@text.literal"] = "TSLiteral",
    ["@text.math"] = "TSMath",
    ["@text.note"] = "TSNote",
    ["@text.reference"] = "TSTextReference",
    ["@text.strike"] = "TSStrike",
    ["@text.strong"] = "TSStrong",
    ["@text.title"] = "TSTitle",
    ["@text.underline"] = "TSUnderline",
    ["@text.uri"] = "TSURI",
    ["@text.warning"] = "TSWarning",
  }

  if hashMap[key] ~= nil then
    return hashMap[key]
  end

	return "TS" .. (string.gsub(key, ".(%w+)" , capitalize))
end

return function()
  -- https://github.com/nvim-treesitter/nvim-treesitter/blob/v0.8.1/CONTRIBUTING.md

  local higlights = {
    -- @attribute             ; attribute annotations (e.g. Python decorators)
    -- @character         ; character literals
    -- @character.special ; special characters (e.g. wildcards)
    -- @conceal ; for captures that are only used for concealing
    -- @conceal must be followed by (#set! conceal "").
    -- @define   ; preprocessor definition directives
    -- @none     ; completely disable the highlight
    -- @nospell ; for defining regions that should NOT be spellchecked
    -- @reference             ; identifier reference
    -- @scope                 ; scope block
    -- @spell   ; for defining regions to be spellchecked
    -- @storageclass          ; visibility/life-time modifiers
    -- @symbol           ; symbols or atoms
    -- @text.danger           ; danger/error notes
    -- @text.diff.add         ; added text (for diff files)
    -- @text.diff.delete      ; deleted text (for diff files)
    -- @text.emphasis         ; text with emphasis
    -- @text.environment      ; text environments of markup languages
    -- @text.environment.name ; text indicating the type of an environment
    -- @text.literal          ; literal or verbatim text
    -- @text.math             ; math environments (e.g. `$ ... $` in LaTeX)
    -- @text.note             ; info notes
    -- @text.reference        ; text references, footnotes, citations, etc.
    -- @text.strike           ; strikethrough text
    -- @text.strong           ; bold text
    -- @text.title            ; text that is part of a title
    -- @text.todo             ; todo notes
    -- @text.underline        ; underlined text
    -- @text.uri              ; URIs (e.g. hyperlinks)
    -- @text.warning          ; warning notes
    ["@boolean"] = groups.Boolean,
    ["@comment"] = groups.Comments,
    ["@conditional"] = groups.Keyword,
    ["@conditional.ternary"] = groups.Punctuation,
    ["@constant"] = groups.Variable,
    ["@constant.builtin"] = groups.Variable,
    ["@constant.macro"] = groups.Variable,
    ["@constructor"] = groups.Type,
    ["@debug"] = groups.Keyword,
    ["@definition"] = groups.Keyword,
    ["@definition.associated"] = groups.Keyword,
    ["@definition.enum"] = groups.Keyword,
    ["@definition.field"] = groups.Keyword,
    ["@definition.function"] = groups.Keyword,
    ["@definition.import"] = groups.Keyword,
    ["@definition.macro"] = groups.Keyword,
    ["@definition.method"] = groups.Keyword,
    ["@definition.namespace"] = groups.Keyword,
    ["@definition.parameter"] = groups.Keyword,
    ["@definition.type"] = groups.Keyword,
    ["@definition.var"] = groups.Keyword,
    ["@error"] = groups.Error,
    ["@exception"] = groups.Keyword,
    ["@field"] = groups.Property,
    ["@float"] = groups.Number,
    ["@function"] = groups.Function,
    ["@function.builtin"] = groups.Function,
    ["@function.call"] = groups.Function,
    ["@function.macro"] = groups.Function,
    ["@include"] = groups.Keyword,
    ["@keyword"] = groups.Keyword,
    ["@keyword.function"] = groups.Keyword,
    ["@keyword.operator"] = groups.Keyword,
    ["@keyword.return"] = groups.Keyword,
    ["@label"] = { guifg = C.yellow, guibg = nil, gui = 'none', guisp = nil },
    ["@method"] = groups.Function,
    ["@method.call"] = groups.Function,
    ["@namespace"] = groups.Type,
    ["@number"] = groups.Number,
    ["@operator"] = groups.Punctuation,
    ["@parameter"] = groups.Variable,
    ["@preproc"] = groups.Comments,
    ["@property"] = groups.Property,
    ["@punctuation.bracket"] = groups.Punctuation,
    ["@punctuation.delimiter"] = groups.Punctuation,
    ["@punctuation.special"] = groups.Punctuation,
    ["@repeat"] = groups.Keyword,
    ["@string"] = groups.String,
    ["@string.escape"] = groups.Number,
    ["@string.regex"] = groups.Regex,
    ["@string.special"] = groups.String,
    ["@tag"] = groups.Tag,
    ["@tag.attribute"] = groups.Property,
    ["@tag.delimiter"] = groups.Punctuation,
    ["@text"] = groups.Text,
    ["@type"] = groups.Type,
    ["@type.builtin"] = groups.Type,
    ["@type.definition"] = groups.Type,
    ["@type.qualifier"] = groups.Type,
    ["@variable"] = groups.Variable,
    ["@variable.builtin"] = groups.Type,
  }

  local result = {}

  for key, value in pairs(higlights) do
    local legacyKey = mapKeyToLegacy(key)
    result[legacyKey] = value
  end
  -- P(result)
  return result
end
-- local legacy = {
--   -- TSAnnotation         = { guifg = C.pink, guibg = nil, gui = 'none', guisp = nil },
--   -- TSAttribute          = { guifg = C.yellow, guibg = nil, gui = 'none', guisp = nil },
--   -- TSCharacter          = { guifg = C.red, guibg = nil, gui = 'none', guisp = nil },
--   -- TSCharacterSpecial
--   -- TSConstMacro         = { guifg = C.red, guibg = nil, gui = 'none', guisp = nil },
--   -- TSDanger
--   -- TSDebug
--   -- TSDefine
--   -- TSDefinition      = { guifg = nil, guibg = nil, gui = 'underline', guisp = C.fg_secondary },
--   -- TSDefinitionUsage = { guifg = nil, guibg = nil, gui = 'underline', guisp = C.fg_secondary },
--   -- TSEnvironment
--   -- TSEnvironmentName
--   -- TSMath
--   -- TSNote
--   -- TSPreProc
--   -- TSStringSpecial
--   -- TSTagAttribute
--   -- TSTextReference
--   -- TSTodo
--   -- TSWarning
--   TSBoolean            = groups.Boolean,
--   TSComment            = groups.Comments,
--   TSConditional        = groups.Keyword,
--   TSConstBuiltin       = groups.Variable,
--   TSConstant           = groups.Variable,
--   TSConstructor        = groups.Type,
--   TSCurrentScope    = { guifg = nil, guibg = nil, gui = 'bold', guisp = nil },
--   TSEmphasis           = { guifg = C.orange, guibg = nil, gui = 'italic', guisp = nil },
--   TSError              = { guifg = C.red, guibg = nil, gui = 'none', guisp = nil },
--   TSException          = groups.Keyword,
--   TSField              = groups.Property,
--   TSFloat              = groups.Number,
--   TSFuncBuiltin        = groups.Function,
--   TSFuncMacro          = groups.Function,
--   TSFuncionCall        = groups.Function,
--   TSFunction           = groups.Function,
--   TSInclude            = groups.Keyword,
--   TSKeyword            = groups.Keyword,
--   TSKeywordFunction    = groups.Keyword,
--   TSKeywordOperator    = groups.Keyword,
--   TSKeywordReturn      = groups.Keyword,
--   TSLabel              = { guifg = C.yellow, guibg = nil, gui = 'none', guisp = nil },
--   TSLiteral            = { guifg = C.orange, guibg = nil, gui = 'none', guisp = nil },
--   TSMethod             = groups.Function,
--   TSMethodCall         = groups.Function,
--   TSNamespace          = { guifg = C.red, guibg = nil, gui = 'none', guisp = nil },
--   TSNone               = { guifg = C.fg_primary, guibg = nil, gui = 'none', guisp = nil },
--   TSNumber             = groups.Number,
--   TSOperator           = groups.Punctuation,
--   TSParameter          = groups.Variable,
--   TSParameterReference = groups.Property,
--   TSProperty           = groups.Property,
--   TSPunctBracket       = groups.Punctuation,
--   TSPunctDelimiter     = groups.Punctuation,
--   TSPunctSpecial       = groups.Punctuation,
--   TSRepeat             = groups.Keyword,
--   TSStrike             = { guifg = C.bg_primary, guibg = nil, gui = 'strikethrough', guisp = nil },
--   TSString             = groups.String,
--   TSStringEscape       = { guifg = C.yellow, guibg = nil, gui = 'none', guisp = nil },
--   TSStringRegex        = { guifg = C.green, guibg = nil, gui = 'none', guisp = nil },
--   TSStrong             = { guifg = nil, guibg = nil, gui = 'bold', guisp = nil },
--   TSSymbol             = { guifg = C.green, guibg = nil, gui = 'none', guisp = nil },
--   TSTag                = groups.Tag,
--   TSTagDelimiter       = groups.Punctuation,
--   TSText               = { guifg = C.fg_primary, guibg = nil, gui = 'none', guisp = nil },
--   TSTitle              = { guifg = C.blue, guibg = nil, gui = 'none', guisp = nil },
--   TSType               = groups.Type,
--   TSTypeBuiltin        = groups.Type,
--   TSTypeDefinition     = groups.Type,
--   TSTypeQualifier      = groups.Type,
--   TSURI                = { guifg = C.orange, guibg = nil, gui = 'underline', guisp = nil },
--   TSUnderline          = { guifg = C.bg_primary, guibg = nil, gui = 'underline', guisp = nil },
--   TSVariable           = groups.Variable,
--   TSVariableBuiltin    = { guifg = C.green, guibg = nil, gui = 'none', guisp = nil },
-- }
