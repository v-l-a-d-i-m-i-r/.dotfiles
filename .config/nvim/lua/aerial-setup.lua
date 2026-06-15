require('aerial').setup({
  keymaps = {
    ['<S-Tab>'] = 'actions.prev_up',
    ['<Tab>'] = 'actions.next_up',
  },
  highlight_on_hover = true,
  show_guides = false,
  layout = {
    resize_to_content = true,
    max_width = 100,
    min_width = 0,
  },
})

vim.keymap.set('n', '<leader>s', '<cmd>AerialToggle!<CR>')
