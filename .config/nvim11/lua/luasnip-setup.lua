-- https://sbulav.github.io/vim/neovim-setting-up-luasnip/
-- https://ejmastnak.com/tutorials/vim-latex/luasnip/
local luasnip = require('luasnip')
local snippet = luasnip.snippet
local insert_node = luasnip.insert_node
local text_node = luasnip.text_node

local cl_snippet = snippet({
  trig = 'cl',
  namr = 'Console log',
  dscr = 'Console log',
}, {
  text_node('console.log('),
  insert_node(1, 'data'),
  text_node(');'),
})

local clj_snippet = snippet({
  trig = 'clj',
  namr = 'Console log JSON',
  dscr = 'Console log formatted JSON',
}, {
  text_node('console.log(JSON.stringify('),
  insert_node(1, 'data'),
  text_node(', null, 2));'),
})

local stt_snippet = snippet({
  trig = 'stt',
  namr = 'Set timeout and try catch',
  dscr = 'Set timeout and try catch',
}, {
  text_node({
    'setTimeout(async () => {',
    '  try {',
    '',
  }),
  insert_node(1, 'data'),
  text_node({
    '',
    '  } catch (error) {',
    '    console.log(error)',
    '  }',
    '}, 2000)',
  }),
})

luasnip.add_snippets(nil, {
  typescript = {
    cl_snippet,
    clj_snippet,
    stt_snippet,
  },
  javascript = {
    cl_snippet,
    clj_snippet,
    stt_snippet,
  },
})
