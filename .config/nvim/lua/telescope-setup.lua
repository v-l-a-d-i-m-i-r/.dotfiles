local actions = require("telescope.actions")
local layout = {
  sorting_strategy = "ascending",
  layout_config = {
    prompt_position = "top",
  }
}

require("telescope").setup({
  defaults = {
    file_ignore_patterns = {
      ".git",
      "plugged",
      "components/",
    },
    -- generic_sorter = require'telescope.sorters'.get_fzy_sorter,
    -- file_sorter = require'telescope.sorters'.get_fzy_sorter,
    mappings = {
      n = {
        ["fj"] = actions.close,
      },
    },
  },
  pickers = {
    find_files = layout,
    live_grep = layout,
    grep_string = layout,
  },
})

-- nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
-- nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
vim.api.nvim_set_keymap('n', '<space>ff', '<cmd>lua require("telescope.builtin").find_files({ hidden = true })<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<space>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<space>f/', '<cmd>lua require("telescope.builtin").grep_string()<cr>', { noremap = true })
