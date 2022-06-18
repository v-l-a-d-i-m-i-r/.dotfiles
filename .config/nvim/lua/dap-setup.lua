-- https://github.com/mfussenegger/nvim-dap/issues/20
-- https://alpha2phi.medium.com/neovim-lsp-and-dap-using-lua-3fb24610ac9f
-- remove the loaded package from a cache, otherwise the package will not be reloaded
-- package.loaded['mpack'] = nil

local dap = require("dap")
local c = require("components")
require('dap.ext.vscode').load_launchjs(nil, {
  node = {
    "javascript",
  },
})

dap.adapters.node = {
  type = 'executable',
  -- command = c.get_component("node-16.14.2").bin("node"),
  command = "node",
  args = {
    c.get_component("vscode-node-debug2-1.43.0").bin("nodeDebug.js")
  },
}

vim.api.nvim_set_keymap("n", "<space>dd", "<cmd>lua require'dap'.continue()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<space>dt", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })
