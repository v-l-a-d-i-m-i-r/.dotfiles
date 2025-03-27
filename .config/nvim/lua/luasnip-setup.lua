-- https://sbulav.github.io/vim/neovim-setting-up-luasnip/
local ls = require('luasnip')
local snip = ls.snippet
local insert = ls.insert_node
local text = ls.text_node

local cl_snippet = snip({
  trig = 'cl',
  namr = 'Console log',
  dscr = 'Console log',
}, {
  text('console.log('),
  insert(1, 'data'),
  text(');'),
})

local clj_snippet = snip({
  trig = 'clj',
  namr = 'Console log JSON',
  dscr = 'Console log formatted JSON',
}, {
  text('console.log(JSON.stringify('),
  insert(1, 'data'),
  text(', null, 2));'),
})

ls.add_snippets(nil, {
  typescript = {
    cl_snippet,
    clj_snippet,
  },
  javascript = {
    cl_snippet,
    clj_snippet,
  },
})
