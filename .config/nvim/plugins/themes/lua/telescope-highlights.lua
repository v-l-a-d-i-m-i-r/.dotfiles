return function(params)
  local C = params.colors

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
