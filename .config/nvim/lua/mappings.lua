-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

vim.api.nvim_set_keymap('n', '<leader>o', 'o<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>O', 'O<Esc>', { noremap = true, silent = true })

-- Reload init.lua (:so %)
vim.api.nvim_set_keymap('n', '<leader><leader>', 'za', { noremap = true, silent = true })

-- Move text
-- https://vim.fandom.com/wiki/Moving_lines_up_or_down
vim.api.nvim_set_keymap('v', '<A-h>', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-j>', ":m '>+1<CR>gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<a-k>', ":m '<-2<CR>gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-l>', '>gv', { noremap = true, silent = true })

-- Vim-Tmux navigator
vim.api.nvim_set_keymap('n', '<C-h>', ':TmuxNavigateLeft<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', ':TmuxNavigateDown<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':TmuxNavigateUp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':TmuxNavigateRight<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-\\>', ':TmuxNavigatePrevious<CR>', { noremap = true, silent = true })

-- Vim-Tmux resizer
vim.api.nvim_set_keymap('n', '<A-h>', ':TmuxResizeLeft<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-j>', ':TmuxResizeDown<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-k>', ':TmuxResizeUp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-l>', ':TmuxResizeRight<CR>', { noremap = true, silent = true })

-- Naviagate buffers
vim.api.nvim_set_keymap('n', '<S-l>', ':bn<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-h>', ':bp<CR>', { noremap = true, silent = true })

-- Yank to clipboard
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>Y', '"+Y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>Y', '"+Y', { noremap = true, silent = true })

-- Put from clipboard
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>P', '"+P', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>P', '"+P', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'p', '"_dP', { noremap = true, silent = true })

-- Clear highlighting on escape in normal mode
vim.api.nvim_set_keymap('n', '<Esc>', ':noh<CR><Esc>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Esc>^[', '<Esc>^[', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>z', ':%s/<C-R><C-W>/<C-R>0/g<CR><C-O>', { noremap = true, silent = true })
