local blink = require('blink.cmp')
local assets = require('assets')

blink.setup({
  appearance = {
    kind_icons = assets.kind_icons,
  },
  sources = {
    default = {
      'avante',
      'lsp',
      'path',
      'snippets',
      'buffer',
    },
    providers = {
      avante = {
        module = 'blink-cmp-avante',
        name = 'Avante',
        opts = {
          -- options for blink-cmp-avante
        },
      },
    },
  },
  snippets = {
    preset = 'luasnip',
  },
  keymap = {
    preset = 'default',
    ['<Tab>'] = { 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
  },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
      window = {
        border = 'single',
      },
    },
    list = {
      selection = {
        preselect = false,
      },
    },
    menu = {
      draw = {
        align_to = 'label',
        columns = {
          { 'label', 'label_description', gap = 1 },
          { 'kind_icon', 'kind', gap = 1 },
          { 'source_name' },
        },
      },
    },
  },
  signature = {
    enabled = true,
    window = {
      border = 'single',
    },
  },
})
