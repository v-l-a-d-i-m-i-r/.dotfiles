require('trouble').setup({
  use_diagnostic_signs = true,
  auto_preview = false,
  pinned = true,
  warn_no_results = false,
  open_no_results = true,
  -- mode = "document_diagnostics",
  icons = {
    indent = {
      middle = ' ',
      last = ' ',
      top = ' ',
      ws = '│  ',
    },
  },
  modes = {
    diagnostics = {
      groups = {
        { 'filename', format = '{file_icon} {basename:Title} {count}' },
      },
    },
  },
})

vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { noremap = true })
