local c = require("colors-definitions").colors

return {
  Function = {
    fg = c.yellow,

    guifg = c.yellow,
    gui = 'none',
  },
  Keyword = {
    fg = c.blue,

    guifg = c.blue,
    gui = 'none',
  },
  Property = {
    fg = c.cyan,

    guifg = c.cyan,
    gui = 'none',
  },
  String = {
    fg = c.orange,

    guifg = c.orange,
    gui = 'none',
  },
  Number = {
    fg = c.pink,

    guifg = c.pink,
    gui = 'none',
  },
  Boolean = {
    fg = c.blue,

    guifg = c.blue,
    gui = 'none',
  },
  Variable = {
    fg = c.cyan,

    guifg = c.cyan,
    gui = 'none',
  },
  Type = {
    fg = c.green,

    guifg = c.green,
    gui = 'none',
  },
  Punctuation = {
    fg = c.fg_primary,

    guifg = c.fg_primary,
    gui = 'none',
  },
  SignAdd = {
    fg = c.cyan,

    guifg = c.cyan,
    gui = 'none',
  },
  SignChange = {
    fg = c.yellow,

    guifg = c.yellow,
    gui = 'none',
  },
  SignDelete = {
    fg = c.red,

    guifg = c.red,
    gui = 'none',
  },
  Comments = {
    fg = c.fg_comments,

    guifg = c.fg_comments,
    gui = 'none',
  },
  IndentGuides = {
    fg = c.fg_comments,

    guifg = c.fg_comments,
    gui = 'none',
  },
}
