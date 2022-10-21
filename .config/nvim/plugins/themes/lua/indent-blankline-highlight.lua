local groups = require("groups-highlight")
local C = require("colors-definitions").colors

return function ()
  return {
    IndentBlanklineChar        = groups.IndentGuides,
    IndentBlanklineContextChar = { fg = C.fg_secondary, guifg = C.fg_secondary, gui = 'none',},
  }
end
