-- https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/options.lua
local function join(list, separator)
  return table.concat(list, separator or ",")
end

vim.opt.title = true
vim.opt.encoding = "UTF-8"
vim.opt.expandtab = true -- on pressing tab, insert 2 spaces
vim.opt.shiftwidth = 2 -- when indenting with '>', use 2 spaces width
vim.opt.tabstop = 2 -- show existing tab with 2 spaces width
vim.opt.softtabstop = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
-- vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.cursorline = false
vim.opt.cursorcolumn = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.wrap = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
vim.opt.list = true
vim.opt.guicursor = "n-v-c:blinkon1"
vim.opt.signcolumn = "yes:1"
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
  "diff:╱",
  "foldclose:",
  "foldopen:",
  -- "msgsep:─",
})
vim.opt.completeopt={"menu", "menuone", "noselect"}
vim.opt.fixendofline = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99 -- open all folds
-- vim.opt.foldlevel = 1
-- vim.opt.foldenable = false
-- vim.opt.foldcolumn = "1"
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.opt.viewoptions = { "folds", "cursor" }
-- vim.opt.sessionoptions = "foldsk"
