local dressing = require('dressing')

dressing.setup({
  input = {
    override = function(conf)
      local bufname = vim.api.nvim_buf_get_name(0)
      local filetype = vim.bo.filetype

      -- Disable dressing if rename is triggered from nvim-tree
      if filetype == 'NvimTree' then
        return false
      end

      return true
    end,
  },
})
