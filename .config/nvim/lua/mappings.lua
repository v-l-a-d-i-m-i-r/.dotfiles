-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- map("i", "fj", "<Esc>")
-- map("v", "fj", "<Esc>")
map("n", "<space>o", "o<Esc>")
map("n", "<space>O", "O<Esc>")

-- Reload init.lua (:so %)
vim.api.nvim_set_keymap("n", "<space><space>", ":so %<CR>", { noremap = true, silent = true })

-- Move text
-- https://vim.fandom.com/wiki/Moving_lines_up_or_down
vim.api.nvim_set_keymap("v", "<A-h>", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<CR>gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<a-k>", ":m '<-2<CR>gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-l>", ">gv", { noremap = true, silent = true })

-- Better window navigation
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Resize window
vim.api.nvim_set_keymap("n", "<A-h>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-j>", ":resize +2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-k>", ":resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-l>", ":vertical resize +2<CR>", { noremap = true, silent = true })

-- Naviagate buffers
vim.api.nvim_set_keymap("n", "<S-l>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-h>", ":bprevious<CR>", { noremap = true, silent = true })

-- Yank to clipboard
vim.api.nvim_set_keymap("n", "<space>y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<space>y", '"+y', { noremap = true, silent = true })

-- Put from clipboard
vim.api.nvim_set_keymap("n", "<space>p", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<space>P", '"+P', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<space>p", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<space>P", '"+P', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "p", '"_dP', { noremap = true, silent = true })
