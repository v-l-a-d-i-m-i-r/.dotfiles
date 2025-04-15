require('aerial').setup({
  keymaps = {
    ['<S-Tab>'] = 'actions.prev_up',
    ['<Tab>'] = 'actions.next_up',
  },
  highlight_on_hover = true,
  show_guides = false,
})

vim.keymap.set('n', '<space>s', '<cmd>AerialToggle!<CR>')
