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
      "lua_modules",
      "node_modules",
    },
    -- generic_sorter = require'telescope.sorters'.get_fzy_sorter,
    -- file_sorter = require'telescope.sorters'.get_fzy_sorter,
    mappings = {
      n = {
        ['\\'] = actions.select_vertical,
        ['-'] = actions.select_horizontal,
      },
    },
  },
  pickers = {
    find_files = layout,
    live_grep = layout,
    grep_string = layout,
    current_buffer_fuzzy_find = layout,
  },
  extentions = {
    live_grep_args = layout,
  },
})

require('telescope').load_extension('fzf')
require("telescope").load_extension("live_grep_args")

-- nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
-- nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
-- vim.api.nvim_set_keymap('n', '<space>ff', '<cmd>lua require("telescope.builtin").find_files({ hidden = true , no_ignore = true })<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<space>ff', '<cmd>lua require("telescope.builtin").find_files({ hidden = true })<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<space>fg', '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<space>f/', '<cmd>lua require("telescope.builtin").grep_string()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<space>f/', '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<cr>', { noremap = true })
