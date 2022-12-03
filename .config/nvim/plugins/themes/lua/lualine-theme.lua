local C = require("colors-definitions").colors

return function ()
  local normal = C.blue
  local visual = C.orange
  local replace = C.red
  local insert = C.green
  return {
    normal = {
      a = { fg = C.bg_primary, bg = normal, gui = 'bold' },
      b = { fg = normal, bg = C.bg_secondary },
      c = { fg = C.fg_secondary, bg = C.bg_secondary },
    },
    visual = {
      a = { fg = C.bg_primary, bg = visual, gui = 'bold' },
      b = { fg = visual, bg = C.bg_secondary },
      c = { fg = C.fg_secondary, bg = C.bg_secondary },
    },
    -- inactive = {
    --   a = { fg = C.bg_primary, bg = C.purple, gui = 'bold' },
    --   b = { fg = C.purple, bg = C.bg_secondary },
    --   c = { fg = C.fg_secondary, bg = C.bg_secondary },
    -- },
    replace = {
      a = { fg = C.bg_primary, bg = replace, gui = 'bold' },
      b = { fg = replace, bg = C.bg_secondary },
      c = { fg = C.fg_secondary, bg = C.bg_secondary },
    },
    insert = {
      a = { fg = C.bg_primary, bg = insert, gui = 'bold' },
      b = { fg = insert, bg = C.bg_secondary },
      c = { fg = C.fg_secondary, bg = C.bg_secondary },
    },
  }
end
