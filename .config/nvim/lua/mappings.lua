vim.api.nvim_set_keymap('n', 'j', '<Plug>(faster_move_j)', {noremap=false, silent=true})
vim.api.nvim_set_keymap('n', 'k', '<Plug>(faster_move_k)', {noremap=false, silent=true})


-- noremap <Up> <Nop>
-- noremap <Down> <Nop>
-- noremap <Left> <Nop>
-- noremap <Right> <Nop>
-- nnoremap <C-n> :NERDTreeToggle<CR>
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Map leader to space
vim.g.mapleader = ","

map("n", "<C-n>", ":NERDTreeToggle<CR>", { silent = true })
map("i", "jk", "<Esc>")
map("v", "jk", "<Esc>")
