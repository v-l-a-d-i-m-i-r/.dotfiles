local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    file_ignore_patterns = {
      ".git",
      "plugged",
    },
    mappings = {
      n = {
        ["fj"] = actions.close,
      },
    },
  },
})

-- nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
-- nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
-- nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
-- nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
vim.api.nvim_set_keymap('n', 'ff', '<cmd>lua require("telescope.builtin").find_files({ hidden = true })<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', 'fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', {noremap = true})
