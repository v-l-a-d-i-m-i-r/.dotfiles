vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_show_icons = {
     git = 1,
     folders = 1,
     files = 1,
     folder_arrows = 1,
    }

require('nvim-tree').setup({
  view = {
    number = true,
    relativenumber = true,
  },
  renderer = {
    indent_markers = {
      enable = true,
    }
  }
})

vim.api.nvim_set_keymap("n", "<space>n", ":NvimTreeToggle<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })
