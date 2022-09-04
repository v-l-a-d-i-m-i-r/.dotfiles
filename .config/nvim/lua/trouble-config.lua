require("trouble").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}


vim.api.nvim_set_keymap('n', '<space>t', '<cmd>TroubleToggle document_diagnostics<cr>', {noremap = true})
