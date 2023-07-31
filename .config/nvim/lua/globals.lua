P = function(v)
  return vim.api.nvim_echo({ { vim.inspect(v) } }, true, {})
end
