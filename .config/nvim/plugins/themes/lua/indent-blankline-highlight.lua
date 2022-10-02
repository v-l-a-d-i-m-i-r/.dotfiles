local groups = require("groups-highlight")
local C = require("colors-definitions")

return function ()
  return {
    IndentBlanklineChar        = groups.IndentGuides,
    IndentBlanklineContextChar = groups.IndentGuides,
  }
end
