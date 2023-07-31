require("bufferline").setup{
  options = {
    numbers = "none",
    show_buffer_icons = true,
    show_close_icon = false,
    custom_filter = function(buf_number, buf_numbers)
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= "[dap-repl]" then
        return true
      end
    end
  },
}
