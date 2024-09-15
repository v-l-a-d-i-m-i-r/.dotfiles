local kind_icons = require('assets').kind_icons
local borders = require('assets').borders
local luasnip = require('luasnip')

local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)

      -- Source
      vim_item.menu = ({
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
        nvim_lua = '[Lua]',
        latex_symbols = '[LaTeX]',
      })[entry.source.name]

      return vim_item
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'luasnip' },
    -- { name = 'buffer' },
  },
  window = {
    -- completion = {
    -- border = {
    --   { borders.top_left_corner, 'FloatBorder' },
    --   { borders.horisontal, 'FloatBorder' },
    --   { borders.top_right_corner, 'FloatBorder' },
    --   { borders.vertical, 'FloatBorder' },
    --   { borders.bottom_right_corner, 'FloatBorder' },
    --   { borders.horisontal, 'FloatBorder' },
    --   { borders.bottom_left_corner, 'FloatBorder' },
    --   { borders.vertical, 'FloatBorder' },
    -- },
    -- winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None',
    -- },
    documentation = {
      border = {
        borders.top_left_corner,
        borders.horisontal,
        borders.top_right_corner,
        borders.vertical,
        borders.bottom_right_corner,
        borders.horisontal,
        borders.bottom_left_corner,
        borders.vertical,
      },
    },
  },
})
