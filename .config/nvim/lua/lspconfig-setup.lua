-- https://github.com/iamcco/diagnostic-languageserver
local lspconfig = require("lspconfig")
local opts = { noremap = true, silent = true }

vim.diagnostic.config({ virtual_text = false })

vim.cmd [[
  sign define DiagnosticSignError text= linehl= texthl=DiagnosticSignError numhl=
  sign define DiagnosticSignWarn text= linehl= texthl=DiagnosticSignWarn numhl=
  sign define DiagnosticSignInfo text= linehl= texthl=DiagnosticSignInfo numhl=
  sign define DiagnosticSignHint text= linehl= texthl=DiagnosticSignHint numhl=
]]

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local c = require("components-plugin")

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    c.get_component("lua-language-server:3.2.4").bin("lua-language-server"),
  },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    c.get_component("node:16.14.2").bin("node"),
    c.get_component("typescript-language-server:0.10.1").bin("typescript-language-server"),
    "--stdio",
  },
}

lspconfig.eslint.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    c.get_component("node:14.17.5").bin("node"),
    c.get_component("vscode-langservers-extracted:4.2.1").bin("vscode-eslint-language-server"),
    "--stdio",
  },
}

lspconfig.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    c.get_component("node:14.17.5").bin("node"),
    c.get_component("bash-language-server:3.0.3").bin("bash-language-server"),
    "start",
  }
}
