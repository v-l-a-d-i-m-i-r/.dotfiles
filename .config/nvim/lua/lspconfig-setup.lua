-- https://github.com/iamcco/diagnostic-languageserver
local diagnostic_icons = require('icons').diagnostic_icons
local lspconfig = require('lspconfig')

local opts = { noremap = true, silent = true }

vim.diagnostic.config({ virtual_text = false })

vim.cmd(
  'sign define DiagnosticSignError text=' .. diagnostic_icons.error .. ' linehl= texthl=DiagnosticSignError numhl='
)
vim.cmd('sign define DiagnosticSignWarn text=' .. diagnostic_icons.warn .. ' linehl= texthl=DiagnosticSignWarn numhl=')
vim.cmd('sign define DiagnosticSignInfo text=' .. diagnostic_icons.info .. ' linehl= texthl=DiagnosticSignInfo numhl=')
vim.cmd('sign define DiagnosticSignHint text=' .. diagnostic_icons.hint .. ' linehl= texthl=DiagnosticSignHint numhl=')

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local handlers = {
  ['textDocument/definition'] = function(err, result, method, ...)
    if not vim.tbl_islist(result) then
      return vim.lsp.handlers['textDocument/definition'](err, result, method, ...)
    end

    if vim.tbl_islist(result) and #result == 1 then
      return vim.lsp.handlers['textDocument/definition'](err, result, method, ...)
    end

    local filtered_result = {}
    if vim.tbl_islist(result) and #result > 1 then
      for _, value in ipairs(result) do
        -- if string.match(value.targetUri, 'react/index.d.ts') then
        -- if string.match(value.targetUri, '.d.ts') then
        if string.match(value.targetUri, '/react/') and string.match(value.targetUri, 'index.d.ts') then
          P(value.targetUri)
          goto continue
        end

        table.insert(filtered_result, value)
        ::continue::
      end
    end

    if #filtered_result == 1 then
      return vim.lsp.handlers['textDocument/definition'](err, filtered_result, method, ...)
    end

    if #result > 1 and #filtered_result == 0 then
      return vim.lsp.handlers['textDocument/definition'](err, { result[1] }, method, ...)
    end

    -- return require('telescope.builtin').lsp_definitions(err, result, method, ...)
    -- return require('telescope.builtin').lsp_type_definitions(err, result, method, ...)
    vim.lsp.handlers['textDocument/definition'](err, { result[1] }, method, ...)
  end,
}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- disable LSP higlights (when disabled 'attempt to index field 'semanticTokensProvider' error occures)
  -- client.server_capabilities.semanticTokensProvider = false

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  require('lsp_signature').on_attach({
    hint_prefix = ' ',
  }, bufnr)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    'n',
    '<space>wl',
    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local c = require('components')

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    c.get_component('lua-language-server').bin('lua-language-server'),
  },
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.stdpath('config') .. '/lua'] = true,
        },
        preloadFileSize = 5000,
      },
      telemetry = {
        enable = false,
      },
    },
  },
  handlers = handlers,
})

-- https://github.com/neovim/neovim/issues/22744
lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    c.get_component('node-18.17.1').bin('node'),
    c.get_component('typescript-language-server').bin('typescript-language-server'),
    '--stdio',
  },
  flags = {
    debounce_text_changes = 100,
  },
  init_options = {
    preferences = {
      importModuleSpecifierPreference = 'relative',
      -- importModuleSpecifierEnding = 'minimal',
    },
  },
  handlers = handlers,
})

-- lspconfig.eslint.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   cmd = {
--     c.get_component("node-16.14.2").bin("node"),
--     -- c.get_component("vscode-langservers-extracted-4.7.0").bin("vscode-eslint-language-server"),
--     c.get_component("vscode-langservers-extracted-4.4.0").bin("vscode-eslint-language-server"),
--     "--stdio",
--   },
--   settings = {
--     cmd = {
--       shell = '/bin/bash',
--       arguments = {
--         '-ce',
--         'PATH=' .. c.get_component("node-16.14.2").bin("") .. ':$PATH" "$@"',
--       }
--     }
--   },
--   handlers = {
--     ['eslint/noLibrary'] = function()
--       return {}
--     end,
--   },
--   -- root_dir = function() return vim.loop.cwd() end,
-- })

-- lspconfig.cssls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   cmd = {
--     c.get_component("node-16.14.2").bin("node"),
--     c.get_component("vscode-langservers-extracted-4.7.0").bin("vscode-css-language-server"),
--     "--stdio",
--   },
-- }

-- https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
lspconfig.emmet_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    c.get_component('node-16.14.2').bin('node'),
    c.get_component('emmet-ls-0.3.0').bin('emmet-ls'),
    '--stdio',
  },
})

lspconfig.bashls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    'sh',
    'bash',
    'zsh',
  },
  cmd = {
    c.get_component('node-14.17.5').bin('node'),
    c.get_component('bash-language-server').bin('bash-language-server'),
    'start',
  },
})

lspconfig.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    c.get_component('gotools').bin('gopls'),
  },
})

vim.lsp.handlers['textDocument/references'] = require('telescope.builtin').lsp_references
-- Enable logging for LSP
-- vim.lsp.set_log_level("debug")
