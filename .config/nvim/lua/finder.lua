local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["jk"] = actions.close,
      },
    },
  },
})
