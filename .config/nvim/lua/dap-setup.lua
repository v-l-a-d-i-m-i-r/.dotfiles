-- https://github.com/mfussenegger/nvim-dap/issues/20
-- https://alpha2phi.medium.com/neovim-lsp-and-dap-using-lua-3fb24610ac9f
-- https://alpha2phi.medium.com/neovim-for-beginners-debugging-using-dap-44626a767f57
-- https://github.com/mfussenegger/nvim-dap/discussions/355
-- remove the loaded package from a cache, otherwise the package will not be reloaded
-- package.loaded['mpack'] = nil

local dap = require('dap')
local dapui = require('dapui')
local dap_vscode_js = require('dap-vscode-js')

local c = require('components')

local mappings = {
  node = {
    'javascript',
    'typescript',
  },
  node2 = {
    'javascript',
    'typescript',
  },
  ['pwa-node'] = {
    'javascript',
    'typescript',
  },
}

require('dap.ext.vscode').load_launchjs(nil, mappings)
dap_vscode_js.setup({
  node_path = 'node', -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = c.get_component('vscode-js-debug-1.71.1').bin(''), -- Path to vscode-js-debug installation.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
})

dap.adapters.node2 = function(callback, config)
  local runtime_version = config.runtimeVersion or '16.14.2'

  return callback({
    type = 'executable',
    -- command = c.get_component("node-" .. runtime_version).bin("node"),
    command = 'node',
    args = {
      -- "--enable-source-maps",
      c.get_component('vscode-node-debug2-1.43.0').bin('nodeDebug.js'),
    },
  })
end

dap.adapters.jsDebug = function(callback, config)
  return callback({
    type = 'executable',
    -- command = c.get_component("node-" .. runtime_version).bin("node"),
    command = 'node',
    args = {
      -- "--enable-source-maps",
      c.get_component('vscode-node-debug2-1.43.0').bin('nodeDebug.js'),
    },
  })
end

dapui.setup({})

dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

vim.api.nvim_set_keymap('n', '<space>ds', "<cmd>lua require'dap'.continue()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  'n',
  '<space>dt',
  "<cmd>lua require'dap'.toggle_breakpoint()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap('n', '<space>dh', "<cmd>lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>dj', "<cmd>lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>dk', "<cmd>lua require'dap'.step_back()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>dl', "<cmd>lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>du', "<cmd>lua require'dap'.up()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>dd', "<cmd>lua require'dap'.down()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>dx', "<cmd>lua require'dap'.disconnect()<CR>", { noremap = true, silent = true })

vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'DiagnosticSignHint' })
vim.fn.sign_define('DapBreakpointRejected', { text = '' })

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { 'dap-repl' },
  callback = function()
    require('dap.ext.autocompl').attach()
  end,
})

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = { 'launch.json' },
  callback = function()
    dap.configurations = {}

    require('dap.ext.vscode').load_launchjs(nil, mappings)
  end,
})
