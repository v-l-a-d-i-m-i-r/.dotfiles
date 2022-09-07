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
  String = {
    fg = c.orange,

    guifg = c.orange,
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
    fg = c.fg_secondary,

    guifg = c.fg_secondary,
    gui = 'none',
  }
}
