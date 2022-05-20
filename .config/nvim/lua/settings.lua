local options = {
  title = true,
  encoding = "UTF-8",
  shiftwidth = 2,
  softtabstop = 2,
  number = true,
  relativenumber = true,
  ruler = true,
  expandtab = true,
  hlsearch = true,
  incsearch = true,
  swapfile = false,
  termguicolors = true,
  cursorline = true,
  cursorcolumn = true,
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  wrap = true,
  timeoutlen = 1000,
  ttimeoutlen = 0,
  -- clipboard = "unnamedplus",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/options.lua
