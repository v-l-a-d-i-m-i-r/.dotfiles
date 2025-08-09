-- https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/options.lua
local function join(list, separator)
  return table.concat(list, separator or ',')
end

vim.g.mapleader = ' '
vim.g.editorconfig = true
vim.g.tmux_resizer_no_mappings = 1

vim.opt.title = true
vim.opt.encoding = 'UTF-8'
vim.opt.expandtab = true -- on pressing tab, insert 2 spaces
vim.opt.shiftwidth = 2 -- when indenting with '>', use 2 spaces width
vim.opt.tabstop = 2 -- show existing tab with 2 spaces width
vim.opt.softtabstop = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
-- vim.cmd('set nohlsearch')
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.cursorline = false
vim.opt.cursorcolumn = false
-- vim.opt.scrolloff = 8
vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 8
vim.opt.wrap = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
vim.opt.list = true
vim.opt.guicursor = join({
  'n-v:blinkon1',
  'i-c:ver25',
})
vim.opt.signcolumn = 'yes:1'
vim.opt.autoread = true
-- vim.opt.listchars = join({
--   "tab: ──",
--   "space:·",
--   "nbsp:␣",
--   "trail:•",
--   "eol:↵",
--   "precedes:«",
--   "extends:»"
-- })
vim.opt.fillchars = join({
  -- "vert:▏",
  -- "vert:│",
  'diff:╱',
  'foldclose:',
  'foldopen:',
  -- "msgsep:─",
})
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.fixendofline = true
vim.opt.foldmethod = 'indent'
vim.opt.foldlevelstart = 99 -- open all folds
-- vim.opt.foldlevel = 1
-- vim.opt.foldenable = false
-- vim.opt.foldcolumn = "1"
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.opt.viewoptions = { "folds", "cursor" }
-- vim.opt.sessionoptions = "foldsk"
vim.opt.mouse = ''
vim.opt.showmode = false
