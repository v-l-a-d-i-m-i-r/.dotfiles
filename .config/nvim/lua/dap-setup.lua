-- require('dap.ext.vscode').load_launchjs()
-- https://github.com/mfussenegger/nvim-dap/issues/20
-- https://alpha2phi.medium.com/neovim-lsp-and-dap-using-lua-3fb24610ac9f
local dap = require("dap")

-- dap.adapters.node2 = {
--   type = 'executable',
--   command = 'node',
--   args = {
--     os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js',
--   },
-- }

vim.api.nvim_set_keymap("n", "<space>dd", "<cmd>lua require'dap'.continue()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<space>dt", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })
