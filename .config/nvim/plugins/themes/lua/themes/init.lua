-- https://stackoverflow.com/questions/68317097/how-to-properly-convert-hsl-colors-to-rgb-colors-in-lua
-- https://github.com/EmmanuelOga/columns/blob/master/utils/color.lua

local editor = require("editor-highlights")
local syntax = require("syntax-highlights")
local telescope = require("telescope-highlights")
local treesitter = require("treesitter-highlight")

local hsl_to_hex_string = require("color-utils").hsl_to_hex_string

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

local function setup()
  if vim.fn.exists('syntax_on') then
      vim.cmd('syntax reset')
  end
  vim.cmd('set termguicolors')

  local params = {
    colors = colors,
    base16_colors = base16_colors,
  }

  initialise_base16(editor(params))
  initialise_base16(syntax(params))
  initialise(telescope(params))
  initialise_base16(treesitter(params))
end

return {
  setup = setup,
}
