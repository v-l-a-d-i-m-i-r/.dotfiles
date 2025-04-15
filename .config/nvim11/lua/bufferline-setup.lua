local bufferline = require('bufferline')
bufferline.setup({
  options = {
    numbers = 'none',
    show_buffer_icons = true,
    show_close_icon = false,
    -- separator_style = 'thin',
    style_preset = bufferline.style_preset.minimal, -- or bufferline.style_preset.minimal,
    themable = true,
    color_icons = true,
    custom_filter = function(buf_number, buf_numbers)
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= '[dap-repl]' then
        return true
      end

      return false
    end,
  },
})
