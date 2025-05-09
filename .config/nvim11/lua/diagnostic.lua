local diagnostic_icons = require('assets').diagnostic_icons

vim.diagnostic.config({
  virtual_text = false, -- floating text next to code is too noisy.
  underline = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = diagnostic_icons.error,
      [vim.diagnostic.severity.WARN] = diagnostic_icons.warn,
      [vim.diagnostic.severity.INFO] = diagnostic_icons.info,
      [vim.diagnostic.severity.HINT] = diagnostic_icons.hint,
    },
    texthl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    },
  },
})
