vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { ".zshrc" },
  callback = function()
    vim.cmd "set filetype=bash"
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = { "*" },
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 2000 })
  end,
})
