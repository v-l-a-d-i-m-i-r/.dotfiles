local nvim_tree_config = require("nvim-tree.config")

require('nvim-tree').setup({
  update_cwd = false,
  update_focused_file = {
    enable = true,
    update_cwd = false,
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
    highlight_opened_files = "icon",
    indent_markers = {
      enable = true,
    },
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
    },
  },
  git = {
    ignore = false,
  },
})

vim.api.nvim_set_keymap("n", "<space>n", ":NvimTreeToggle<CR>", { silent = true })
