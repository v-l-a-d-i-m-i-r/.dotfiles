local options = {
  title = true,
  encoding = "UTF-8",
  expandtab = true, -- on pressing tab, insert 2 spaces
  shiftwidth = 2, -- when indenting with '>', use 2 spaces width
  tabstop = 2, -- show existing tab with 2 spaces width
  softtabstop = 2,
  number = true,
  relativenumber = true,
  ruler = true,
  hlsearch = true,
  incsearch = true,
  swapfile = false,
  termguicolors = true,
  cursorline = true,
  cursorcolumn = true,
  scrolloff = 8,
  sidescrolloff = 8,
  wrap = true,
  timeoutlen = 1000,
  ttimeoutlen = 0,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/options.lua
