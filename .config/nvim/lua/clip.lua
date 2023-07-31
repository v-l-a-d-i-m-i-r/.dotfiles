vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  pattern = { '*' },
  callback = function()
    local regname = vim.v.event.regname

    if regname ~= '+' then
      return
    end

    local text = vim.fn.getreg(regname)
    local escape = vim.fn.system('yank', text)

    if vim.v.shell_error ~= 0 then
      vim.api.nvim_err_writeln(escape)
    else
      -- vim.fn.writefile({escape}, '/dev/tty', 'b')
    end
  end,
})
