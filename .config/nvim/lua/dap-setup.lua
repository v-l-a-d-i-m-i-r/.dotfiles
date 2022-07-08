-- https://github.com/mfussenegger/nvim-dap/issues/20
-- https://alpha2phi.medium.com/neovim-lsp-and-dap-using-lua-3fb24610ac9f
-- https://alpha2phi.medium.com/neovim-for-beginners-debugging-using-dap-44626a767f57
-- remove the loaded package from a cache, otherwise the package will not be reloaded
-- package.loaded['mpack'] = nil

local dap = require("dap")
local dapui = require("dapui")

local c = require("components")

require('dap.ext.vscode').load_launchjs(nil, {
  node = {
    "javascript",
  },
})

dap.adapters.node = function (callback, config)
  local runtime_version = config.runtimeVersion or "16.14.2"

  return callback({
    type = 'executable',
    command = c.get_component("node-" .. runtime_version).bin("node"),
    args = {
      c.get_component("vscode-node-debug2-1.43.0").bin("nodeDebug.js")
    },
  })
end

dapui.setup({
  -- layouts = {
  --   {
  --     elements = {
  --     -- Elements can be strings or table with id and size keys.
  --       -- "breakpoints",
  --       { id = "stacks", size = 0.25 },
  --       "scopes",
  --     },
  --     size = 40,
  --     position = "left",
  --   },
  --   {
  --     elements = {
  --       -- "repl",
  --       "console",
  --     },
  --     size = 10,
  --     position = "bottom",
  --   },
  -- },
})
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.api.nvim_set_keymap("n", "<space>ds", "<cmd>lua require'dap'.continue()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<space>dt", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<space>dh", "<cmd>lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<space>dj", "<cmd>lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<space>dk", "<cmd>lua require'dap'.step_back()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<space>dl", "<cmd>lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<space>du", "<cmd>lua require'dap'.up()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<space>dd", "<cmd>lua require'dap'.down()<CR>", { noremap = true, silent = true })
 
vim.fn.sign_define('DapBreakpoint', {text=''})
vim.fn.sign_define('DapBreakpointRejected', {text=''})
-- vim.fn.sign_define('DapStopped', {text=''})
vim.fn.sign_define('DapStopped', {text=''})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "dap-repl" },
  callback = function()
    require('dap.ext.autocompl').attach()
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "launch.json" },
  callback = function()
    dap.configurations = {}

    require('dap.ext.vscode').load_launchjs(nil, {
      node = {
        "javascript",
      },
    })
  end,
})
