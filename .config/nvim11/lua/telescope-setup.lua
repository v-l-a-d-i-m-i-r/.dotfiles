-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes

local borders = require('assets').borders
local actions = require('telescope.actions')

local sorting_strategy = 'ascending'
local layout_config = {
  prompt_position = 'top',
  width = 0.95,
  height = 0.95,
}
local cwd = vim.fn.getcwd()

require('telescope').setup({
  defaults = {
    file_ignore_patterns = {
      '.git/',
      'plugged',
      'nvim/components',
      'lua_modules',
      'node_modules',
      '!.env',
    },
    -- generic_sorter = require'telescope.sorters'.get_fzy_sorter,
    -- file_sorter = require'telescope.sorters'.get_fzy_sorter,
    mappings = {
      n = {
        ['\\'] = actions.select_vertical,
        ['-'] = actions.select_horizontal,
        ['<CR>'] = function(prompt_bufnr)
          actions.select_default(prompt_bufnr)
          actions.center(prompt_bufnr)
        end,
      },
    },
    borderchars = {
      borders.horisontal,
      borders.vertical,
      borders.horisontal,
      borders.vertical,
      borders.top_left_corner,
      borders.top_right_corner,
      borders.bottom_right_corner,
      borders.bottom_left_corner,
    },
  },
  pickers = {
    find_files = {
      sorting_strategy = sorting_strategy,
      layout_config = layout_config,
      cwd = cwd,
      hidden = true,
      -- no_ignore = true,
    },
    live_grep = {
      sorting_strategy = sorting_strategy,
      layout_config = layout_config,
      cwd = cwd,
    },
    grep_string = {
      sorting_strategy = sorting_strategy,
      layout_config = layout_config,
      cwd = cwd,
    },
    current_buffer_fuzzy_find = {
      sorting_strategy = sorting_strategy,
      layout_config = layout_config,
      cwd = cwd,
    },
    lsp_references = {
      sorting_strategy = sorting_strategy,
      layout_config = layout_config,
      cwd = cwd,
      show_line = false,
      file_ignore_patterns = {
        -- '%.spec.ts',
      },
    },
    lsp_definitions = {
      sorting_strategy = sorting_strategy,
      layout_config = layout_config,
      cwd = cwd,
      show_line = false,
    },
    lsp_implementations = {
      sorting_strategy = sorting_strategy,
      layout_config = layout_config,
      cwd = cwd,
      show_line = false,
    },
    buffers = {
      sorting_strategy = sorting_strategy,
      layout_config = layout_config,
      cwd = cwd,
    },
    highlights = {
      sorting_strategy = sorting_strategy,
      layout_config = layout_config,
      cwd = cwd,
    },
  },
  extensions = {
    live_grep_args = {
      sorting_strategy = sorting_strategy,
      layout_config = layout_config,
      cwd = cwd,
      show_line = false,
    },
    fzf = {
      fuzzy = true, -- false will only do exact matching
      -- override_generic_sorter = true, -- override the generic sorter
      -- override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
    },
  },
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('live_grep_args')

vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', { noremap = true })
vim.api.nvim_set_keymap(
  'n',
  '<leader>fg',
  '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>',
  { noremap = true }
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>f/',
  '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<cr>',
  { noremap = true }
)
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>lua require("telescope.builtin").highlights()<cr>', { noremap = true })
