local options = {
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
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/options.lua
