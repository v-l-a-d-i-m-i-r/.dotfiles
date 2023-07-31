require('trouble').setup({
  use_diagnostic_signs = true,
  auto_preview = false,
  -- mode = "document_diagnostics",
})

vim.api.nvim_set_keymap('n', '<space>t', '<cmd>TroubleToggle document_diagnostics<cr>', { noremap = true })
