-- https://stackoverflow.com/questions/68317097/how-to-properly-convert-hsl-colors-to-rgb-colors-in-lua
-- https://github.com/EmmanuelOga/columns/blob/master/utils/color.lua

-- local palette = {
--   base00 = '#2e3440',
--   base01 = '#3b4252',
--   base02 = '#434c5e',
--   base03 = '#4c566a',
--   base04 = '#d8dee9',
--   base05 = '#e5e9f0',
--   base06 = '#eceff4',
--   base07 = '#8fbcbb',
--   base08 = '#bf616a',
--   base09 = '#d08770',
--   base0A = '#ebcb8b',
--   base0B = '#a3be8c',
--   base0C = '#88c0d0',
--   base0D = '#81a1c1',
--   base0E = '#b48ead',
--   base0F = '#5e81ac'
-- }
--
-- -- local palette = {
-- --   base00 = '#1E1E1E',
-- --   base01 = '#262626',
-- --   base02 = '#303030',
-- --   base03 = '#3C3C3C',
-- --   base04 = '#808080',
-- --   base05 = '#D4D4D4',
-- --   base06 = '#E9E9E9',
-- --   base07 = '#FFFFFF',
-- --   base08 = '#D16969',
-- --   base09 = '#B5CEA8',
-- --   base0A = '#CCB17A',
-- --   base0B = '#608B4E',
-- --   base0C = '#9CDCFE',
-- --   base0D = '#5395D4',
-- --   base0E = '#BB80C5',
-- --   base0F = '#CE9178'
-- -- }
-- -- require('base16-colorscheme').setup(palette)
local HEX_DIGITS = {
  ['0'] = 0,
  ['1'] = 1,
  ['2'] = 2,
  ['3'] = 3,
  ['4'] = 4,
  ['5'] = 5,
  ['6'] = 6,
  ['7'] = 7,
  ['8'] = 8,
  ['9'] = 9,
  ['a'] = 10,
  ['b'] = 11,
  ['c'] = 12,
  ['d'] = 13,
  ['e'] = 14,
  ['f'] = 15,
  ['A'] = 10,
  ['B'] = 11,
  ['C'] = 12,
  ['D'] = 13,
  ['E'] = 14,
  ['F'] = 15,
}

local function hex_to_rgb(hex)
  local red = HEX_DIGITS[string.sub(hex, 1, 1)] * 16 + HEX_DIGITS[string.sub(hex, 2, 2)]
  local green = HEX_DIGITS[string.sub(hex, 3, 3)] * 16 + HEX_DIGITS[string.sub(hex, 4, 4)]
  local blue = HEX_DIGITS[string.sub(hex, 5, 5)] * 16 + HEX_DIGITS[string.sub(hex, 6, 6)]

  return red, green, blue
end

local function rgb_to_hex(r, g, b)
  return bit.tohex(bit.bor(bit.lshift(r, 16), bit.lshift(g, 8), b), 6)
end

local function hsl_to_rgb(h, s, l, a)
  h = h / 360
  s = s / 100
  l = l / 100

  local r, g, b;

  if s == 0 then
    r, g, b = l, l, l; -- achromatic
  else
    local function hue2rgb(p, q, t)
      if t < 0 then t = t + 1 end
      if t > 1 then t = t - 1 end
      if t < 1 / 6 then return p + (q - p) * 6 * t end
      if t < 1 / 2 then return q end
      if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
      return p;
    end

    local q = l < 0.5 and l * (1 + s) or l + s - l * s;
    local p = 2 * l - q;
    r = hue2rgb(p, q, h + 1 / 3);
    g = hue2rgb(p, q, h);
    b = hue2rgb(p, q, h - 1 / 3);
  end

  if not a then a = 1 end

  return r * 255, g * 255, b * 255, a * 255
end

local function hsl_to_hex_string(h, s, l)
  return "#" .. rgb_to_hex(hsl_to_rgb(h, s, l, 100))
end

local function highlight(group, properties)
  local bg = properties.bg == nil and "" or "guibg=" .. properties.bg
  local fg = properties.fg == nil and "" or "guifg=" .. properties.fg
  local style = properties.style == nil and "" or "gui=" .. properties.style

  local cmd = table.concat({
    "highlight", group, bg, fg, style
  }, " ")

  vim.api.nvim_command(cmd)
end

local function initialise(skeleton)
  for group, properties in pairs(skeleton) do
    highlight(group, properties)
  end
end

local function initialise_base16(groups)
  for group, props in pairs(groups) do
    -- if ('string' == type(args)) then
    --   vim.cmd(('hi! link %s %s'):format(hlgroup, args))
    --   return
    -- end
    -- P(props)
    local guibg = props.guibg == nil and "" or "guibg=" .. props.guibg
    local guifg = props.guifg == nil and "" or "guifg=" .. props.guifg
    local gui= props.gui == nil and "" or "gui=" .. props.gui
    local guisp = props.guisp == nil and "" or "guisp=" .. props.guisp

    local cmd = table.concat({
      "highlight", group, guifg, guibg, gui, guisp
    }, " ")

    vim.api.nvim_command(cmd)
  end
end

local bg_primary =  hsl_to_hex_string(214, 42, 16) -- base00
local bg_secondary = hsl_to_hex_string(213, 39, 11) -- base01
local bg_selection = hsl_to_hex_string(214, 34, 20) -- base03
local fg_comments = hsl_to_hex_string(213, 29, 33) -- base04

local fg_secondary = hsl_to_hex_string(213, 24, 64) -- base05
local fg_primary = hsl_to_hex_string(214, 32, 70) -- base06
local fg_tertiary = hsl_to_hex_string(212, 37, 92) -- base07
local bg_tertiary = hsl_to_hex_string(210, 36, 96) -- base08

local red = hsl_to_hex_string(3, 30, 40) -- red
local orange = hsl_to_hex_string(27, 30, 40) -- orange
local yellow = hsl_to_hex_string(49, 19, 44) -- yellow
local green = hsl_to_hex_string(102, 19, 44) -- green
local cyan = hsl_to_hex_string(180, 30, 44) -- cyan
local blue = hsl_to_hex_string(203, 30, 44) -- blue
local purple = hsl_to_hex_string(276, 30, 40) -- purple
local pink = hsl_to_hex_string(300, 30, 40) -- pink

local colors = {
  bg_primary = bg_primary,
  bg_secondary = bg_secondary,
  bg_selection = bg_selection,
  fg_comments = fg_comments,

  fg_secondary = fg_secondary,
  fg_primary = fg_primary,
  fg_tertiary = fg_tertiary,
  bg_tertiary = bg_tertiary,

  red = red,
  orange = orange,
  yellow = yellow,
  green = green,
  cyan = cyan,
  blue = blue,
  purple = purple,
  pink = pink,
}

local base16_colors = {
  base00 = bg_primary,
  base01 = bg_secondary,
  base02 = bg_selection,
  base03 = fg_comments,

  base04 = fg_secondary,
  base05 = fg_primary,
  base06 = fg_tertiary,
  base07 = bg_tertiary,

  base08 = red,
  base09 = orange,
  base0A = yellow,
  base0B = green,
  base0C = cyan,
  base0D = blue,
  base0E = purple,
  base0F = pink,
}

local function highlight_vim_editor_colors(c)
  return {
    Normal = {
      bg = c.bg_primary,
      fg = c.fg_primary,
    },
    Bold = {
     style = "bold",
    },

		-- SignColumn = {bg = C.bg, },
		-- MsgArea = {fg = C.fg, bg = Config.transparent_background and "NONE" or C.bg, },
		-- ModeMsg = {fg = C.fg, bg = C.dark, },
		-- MsgSeparator = {fg = C.fg, bg = C.bg, },
		-- SpellBad = {fg = C.light_red, style = "underline", },
		-- SpellCap = {fg = C.yellow, style = "underline", },
		-- SpellLocal = {fg = C.green, style = "underline", },
		-- SpellRare = {fg = C.purple, style = "underline", },
		-- NormalNC = {fg = C.fg, bg = Config.transparent_background and "NONE" or C.bg, },
		-- Pmenu = {fg = C.light_gray, bg = C.tree_gray, },
		-- PmenuSel = {bg = C.ui2_blue, },
		-- WildMenu = {fg = C.fg, bg = C.ui2_blue, },
		-- CursorLineNr = {fg = C.light_gray, style = "bold", },
		-- Comment = {fg = C.gray, style = "italic", },
		-- Folded = {fg = C.accent, bg = C.alt_bg, },
		-- FoldColumn = {fg = C.accent, bg = C.alt_bg, },
		-- LineNr = {fg = C.gray, },
		-- FloatBoder = {fg = C.gray, bg = C.alt_bg, },
		-- Whitespace = {fg = C.bg, },
		-- VertSplit = {fg = C.bg, bg = C.gray, },
		-- CursorLine = {bg = C.dark, },
		-- CursorColumn = {bg = C.dark, },
		-- ColorColumn = {bg = C.dark, },
		-- NormalFloat = {bg = C.dark, },
		-- Visual = {bg = C.ui_blue, },
		-- VisualNOS = {bg = C.alt_bg, },
		-- WarningMsg = {fg = C.error_red, bg = C.bg, },
		-- DiffAdd = {fg = C.alt_bg, bg = C.sign_add, },
		-- DiffChange = {fg = C.alt_bg, bg = C.sign_change, style = "underline", },
		-- DiffDelete = {fg = C.alt_bg, bg = C.sign_delete, },
		-- QuickFixLine = {bg = C.ui2_blue, },
		-- PmenuSbar = {bg = C.alt_bg, },
		-- PmenuThumb = {bg = C.gray, },
		-- MatchWord = {style = "underline", },
		-- MatchParen = {fg = C.hint_blue, bg = C.bg, style = "underline", },
		-- MatchWordCur = {style = "underline", },
		-- MatchParenCur = {style = "underline", },
		-- Cursor = {fg = C.cursor_fg, bg = C.cursor_bg, },
		-- lCursor = {fg = C.cursor_fg, bg = C.cursor_bg, },
		-- CursorIM = {fg = C.cursor_fg, bg = C.cursor_bg, },
		-- TermCursor = {fg = C.cursor_fg, bg = C.cursor_bg, },
		-- TermCursorNC = {fg = C.cursor_fg, bg = C.cursor_bg, },
		-- Conceal = {fg = C.accent, },
		-- Directory = {fg = C.blue, },
		-- SpecialKey = {fg = C.blue, style = "bold", },
		-- Title = {fg = C.blue, style = "bold", },
		-- ErrorMsg = {fg = C.error_red, bg = C.bg, style = "bold", },
		-- Search = {fg = C.light_gray, bg = C.search_blue, },
		-- IncSearch = {fg = C.search_orange, bg = C.light_gray, },
		-- Substitute = {fg = C.light_gray, bg = C.search_orange, },
		-- MoreMsg = {fg = C.orange, },
		-- Question = {fg = C.orange, },
		-- EndOfBuffer = {fg = C.bg, },
		-- NonText = {fg = C.bg, },
		-- Variable = {fg = C.light_blue, },
		-- String = {fg = C.orange, },
		-- Character = {fg = C.orange, },
		-- Constant = {fg = C.vivid_blue, },
		-- Number = {fg = C.light_green, },
		-- Boolean = {fg = C.blue, },
		-- Float = {fg = C.light_green, },
		-- Identifier = {fg = C.light_blue, },
		-- Function = {fg = C.yellow, },
		-- Operator = {fg = C.fg, },
		-- Type = {fg = C.cyan, },
		-- StorageClass = {fg = C.blue, },
		-- Structure = {fg = C.blue, },
		-- Typedef = {fg = C.blue, },
		-- Keyword = {fg = C.blue, },
		-- Statement = {fg = C.purple, },
		-- Conditional = {fg = C.blue, },
		-- Repeat = {fg = C.purple, },
		-- Label = {fg = C.purple, },
		-- Exception = {fg = C.purple, },
		-- Include = {fg = C.purple, },
		-- PreProc = {fg = C.purple, },
		-- Define = {fg = C.purple, },
		-- Macro = {fg = C.purple, },
		-- PreCondit = {fg = C.purple, },
		-- Special = {fg = C.orange, },
		-- SpecialChar = {fg = C.white, },
		-- Tag = {fg = C.blue, },
		-- Debug = {fg = C.red, },
		-- Delimiter = {fg = C.gray, },
		-- SpecialComment = {fg = C.gray, },
		-- Underlined = {style = "underline", },
		-- Bold = {style = "bold", },
		-- Italic = {style = "italic", },
		-- Ignore = {fg = C.cyan, bg = C.bg, style = "bold", },
		-- Todo = {fg = C.magenta, bg = C.bg, style = "bold", },
		-- Error = {fg = C.error_red, bg = C.bg, style = "bold", },
		-- TabLine = {fg = C.light_gray, bg = C.alt_bg, },
		-- TabLineSel = {fg = C.white, bg = C.alt_bg, },
		-- TabLineFill = {fg = C.alt_bg, bg = C.alt_bg, },
  }
end

local function highlight_base16(c)
  return {
    Normal       = { guifg = c.base05, guibg = c.base00, gui = nil, guisp = nil },
    Bold         = { guifg = nil, guibg = nil, gui = 'bold', guisp = nil },
    Debug        = { guifg = c.base08, guibg = nil, gui = nil, guisp = nil },
    Directory    = { guifg = c.base0D, guibg = nil, gui = nil, guisp = nil },
    Error        = { guifg = c.base00, guibg = c.base08, gui = nil, guisp = nil },
    ErrorMsg     = { guifg = c.base08, guibg = c.base00, gui = nil, guisp = nil },
    Exception    = { guifg = c.base08, guibg = nil, gui = nil, guisp = nil },
    FoldColumn   = { guifg = c.base0C, guibg = c.base00, gui = nil, guisp = nil },
    Folded       = { guifg = c.base03, guibg = c.base01, gui = nil, guisp = nil },
    IncSearch    = { guifg = c.base01, guibg = c.base09, gui = 'none', guisp = nil },
    Italic       = { guifg = nil, guibg = nil, gui = 'none', guisp = nil },
    Macro        = { guifg = c.base08, guibg = nil, gui = nil, guisp = nil },
    MatchParen   = { guifg = nil, guibg = c.base03, gui = nil, guisp = nil },
    ModeMsg      = { guifg = c.base0B, guibg = nil, gui = nil, guisp = nil },
    MoreMsg      = { guifg = c.base0B, guibg = nil, gui = nil, guisp = nil },
    Question     = { guifg = c.base0D, guibg = nil, gui = nil, guisp = nil },
    Search       = { guifg = c.base01, guibg = c.base0A, gui = nil, guisp = nil },
    Substitute   = { guifg = c.base01, guibg = c.base0A, gui = 'none', guisp = nil },
    SpecialKey   = { guifg = c.base03, guibg = nil, gui = nil, guisp = nil },
    -- TooLong      = { guifg = colors.base08, guibg = nil, gui = nil, guisp = nil },
    Underlined   = { guifg = c.base08, guibg = nil, gui = nil, guisp = nil },
    Visual       = { guifg = nil, guibg = c.base02, gui = nil, guisp = nil },
    -- VisualNOS    = { guifg = colors.base08, guibg = nil, gui = nil, guisp = nil },
    WarningMsg   = { guifg = c.base08, guibg = nil, gui = nil, guisp = nil },
    WildMenu     = { guifg = c.base08, guibg = c.base0A, gui = nil, guisp = nil },
    Title        = { guifg = c.base0D, guibg = nil, gui = 'none', guisp = nil },
    Conceal      = { guifg = c.base0D, guibg = c.base00, gui = nil, guisp = nil },
    Cursor       = { guifg = c.base00, guibg = c.base05, gui = nil, guisp = nil },
    NonText      = { guifg = c.base03, guibg = nil, gui = nil, guisp = nil },
    LineNr       = { guifg = c.base04, guibg = c.base00, gui = nil, guisp = nil },
    SignColumn   = { guifg = c.base04, guibg = c.base00, gui = nil, guisp = nil },
    StatusLine   = { guifg = c.base05, guibg = c.base02, gui = 'none', guisp = nil },
    StatusLineNC = { guifg = c.base04, guibg = c.base01, gui = 'none', guisp = nil },
    WinBar       = { guifg = c.base05, guibg = nil, gui = 'none', guisp = nil },
    WinBarNC     = { guifg = c.base04, guibg = nil, gui = 'none', guisp = nil },
    VertSplit    = { guifg = c.base05, guibg = c.base00, gui = 'none', guisp = nil },
    ColorColumn  = { guifg = nil, guibg = c.base01, gui = 'none', guisp = nil },
    CursorColumn = { guifg = nil, guibg = c.base01, gui = 'none', guisp = nil },
    CursorLine   = { guifg = nil, guibg = c.base01, gui = 'none', guisp = nil },
    CursorLineNr = { guifg = c.base04, guibg = c.base01, gui = nil, guisp = nil },
    QuickFixLine = { guifg = nil, guibg = c.base01, gui = 'none', guisp = nil },
    PMenu        = { guifg = c.base05, guibg = c.base01, gui = 'none', guisp = nil },
    PMenuSel     = { guifg = c.base01, guibg = c.base05, gui = nil, guisp = nil },
    TabLine      = { guifg = c.base03, guibg = c.base01, gui = 'none', guisp = nil },
    TabLineFill  = { guifg = c.base03, guibg = c.base01, gui = 'none', guisp = nil },
    TabLineSel   = { guifg = c.base0B, guibg = c.base01, gui = 'none', guisp = nil },
  }
end

local function standard_syntax_base16(c)
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

local function telescope_base16(c)
  return {
    TelescopeBorder       = { guifg = c.base00, guibg = c.base00, gui = nil, guisp = nil },
    TelescopePromptBorder = { guifg = c.base02, guibg = c.base02, gui = nil, guisp = nil },
    TelescopePromptNormal = { guifg = c.base05, guibg = c.base02, gui = nil, guisp = nil },
    TelescopePromptPrefix = { guifg = c.base08, guibg = c.base02, gui = nil, guisp = nil },
    TelescopeNormal       = { guifg = nil, guibg = c.base00, gui = nil, guisp = nil },
    TelescopePreviewTitle = { guifg = c.base01, guibg = c.base0B, gui = nil, guisp = nil },
    TelescopePromptTitle  = { guifg = c.base01, guibg = c.base08, gui = nil, guisp = nil },
    TelescopeResultsTitle = { guifg = c.base00, guibg = c.base00, gui = nil, guisp = nil },
    TelescopeSelection    = { guifg = nil, guibg = c.base02, gui = nil, guisp = nil },
    TelescopePreviewLine  = { guifg = nil, guibg = c.base01, gui = 'none', guisp = nil },
  }
end

local function telescope(C)
  return {
    TelescopeSelection = {fg = C.blue, },
		TelescopeMatching = {fg = C.yellow, style = "bold", },
		TelescopeBorder = {fg = C.blue },
  }
end

if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
end
vim.cmd('set termguicolors')

initialise_base16(highlight_base16(base16_colors))
initialise_base16(standard_syntax_base16(base16_colors))
initialise(telescope(colors))
-- initialise(highlight_vim_editor_colors(colors))
