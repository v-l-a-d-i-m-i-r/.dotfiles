vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { ".zshrc" },
  callback = function()
    vim.cmd "set filetype=bash"
  end,
})
