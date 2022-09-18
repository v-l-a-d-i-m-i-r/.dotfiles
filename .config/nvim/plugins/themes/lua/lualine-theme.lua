local C = require("colors-definitions").colors

return function ()
  return {
    normal = {
      a = { fg = C.bg_primary, bg = C.green, gui = 'bold' },
      b = { fg = C.green, bg = C.bg_secondary },
      c = { fg = C.fg_secondary, bg = C.bg_secondary },
    },
    visual = {
      a = { fg = C.bg_primary, bg = C.purple, gui = 'bold' },
      b = { fg = C.purple, bg = C.bg_secondary },
      c = { fg = C.fg_secondary, bg = C.bg_secondary },
    },
    -- inactive = {
    --   a = { fg = C.bg_primary, bg = C.purple, gui = 'bold' },
    --   b = { fg = C.purple, bg = C.bg_secondary },
    --   c = { fg = C.fg_secondary, bg = C.bg_secondary },
    -- },
    replace = {
      a = { fg = C.bg_primary, bg = C.red, gui = 'bold' },
      b = { fg = C.red, bg = C.bg_secondary },
      c = { fg = C.fg_secondary, bg = C.bg_secondary },
    },
    insert = {
      a = { fg = C.bg_primary, bg = C.blue, gui = 'bold' },
      b = { fg = C.blue, bg = C.bg_secondary },
      c = { fg = C.fg_secondary, bg = C.bg_secondary },
    },
  }
end
