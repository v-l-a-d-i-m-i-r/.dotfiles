vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_show_icons = {
   git = 1,
   folders = 1,
   files = 1,
   folder_arrows = 1,
}

local nvim_tree_config = require("nvim-tree.config")

require('nvim-tree').setup({
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  view = {
    number = true,
    relativenumber = true,
    mappings = {
      custom_only = false,
      list = {
        { key = "h", cb = nvim_tree_config.nvim_tree_callback("split") },
        { key = "v", cb = nvim_tree_config.nvim_tree_callback("vsplit") },
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = true,
    }
  },
  git = {
    ignore = false,
  },
})

vim.api.nvim_set_keymap("n", "<space>n", ":NvimTreeToggle<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })
