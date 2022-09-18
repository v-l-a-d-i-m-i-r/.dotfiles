local C = require("groups-highlight")

return function ()
  return {
    IndentBlanklineChar        = C.IndentGuides,
    IndentBlanklineContextChar = C.IndentGuides,
  }
end
