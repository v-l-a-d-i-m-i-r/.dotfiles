-- https://stackoverflow.com/questions/68317097/how-to-properly-convert-hsl-colors-to-rgb-colors-in-lua
-- https://github.com/EmmanuelOga/columns/blob/master/utils/color.lua

local editor = require("editor-highlights")
local syntax = require("syntax-highlights")
local telescope = require("telescope-highlights")
local treesitter = require("treesitter-highlight")
local git = require("git-highlights")
local nvim_tree = require("nvim-tree-highlights")
local inident_blanklines = require("indent-blankline-highlight")
local lsp = require("lsp-highlight")

local hsl_to_hex_string = require("color-utils").hsl_to_hex_string
local lualine_theme = require("lualine-theme")

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

local function setup()
  if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
  end

  vim.cmd('set termguicolors')

  initialise_base16(editor())
  initialise_base16(syntax())
  initialise(telescope())
  initialise_base16(treesitter())
  initialise(git())
  initialise(nvim_tree())
  initialise(inident_blanklines())
  initialise(lsp())

  vim.api.nvim_set_hl(0, "DiffAdd", { fg = "none" , bg = "#193119" })
  vim.api.nvim_set_hl(0, "DiffDelete", { fg = "none" , bg = "#311919" })
  vim.api.nvim_set_hl(0, "DiffChange", { fg = "none" , bg = "#191931" })
  vim.api.nvim_set_hl(0, "DiffText", { fg = "none" , bg = "#0F0F83" })
end

return {
  setup = setup,
  lualine_theme = lualine_theme(),
}
