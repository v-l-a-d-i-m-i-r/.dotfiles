local groups = require("groups-highlight")

return function()
  return {
    SignAdd = groups.SignAdd,
		SignChange = groups.SignChange,
		SignDelete = groups.SignDelete,
		GitSignsAdd = groups.SignAdd,
		GitSignsChange = groups.SignChange,
		GitSignsDelete = groups.SignDelete,
  }
end
