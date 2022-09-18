local C = require("colors-definitions").colors

return function(params)
  return {
    TelescopeSelection = {
      fg = C.blue,
    },
		TelescopeMatching = {
      fg = C.yellow,
      style = "bold",
    },
		TelescopeBorder = {
      fg = C.blue
    },
  }
end
