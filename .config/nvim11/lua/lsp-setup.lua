local nvim_lsp = require('nvim-lsp')
local blink = require('blink.cmp')
local c = require('components')
local borders = require('assets').borders
local utils = require('utils')

vim.keymap.set('n', 'gd', function()
  vim.lsp.buf.definition({
    on_list = function(opts)
      vim.fn.setqflist({}, ' ', opts)
      vim.cmd.cfirst()
    end,
  })
end)
vim.keymap.set('n', 'gD', function()
  vim.lsp.buf.declaration()
end)
vim.keymap.set('n', 'K', function()
  local border = {
    { borders.top_left_corner, 'FloatBorder' },
    { borders.horisontal, 'FloatBorder' },
    { borders.top_right_corner, 'FloatBorder' },
    { borders.vertical, 'FloatBorder' },
    { borders.bottom_right_corner, 'FloatBorder' },
    { borders.horisontal, 'FloatBorder' },
    { borders.bottom_left_corner, 'FloatBorder' },
    { borders.vertical, 'FloatBorder' },
  }

  vim.lsp.buf.hover({ border = border })
end)
vim.keymap.set('n', 'gi', function()
  require('telescope.builtin').lsp_implementations()
end)
vim.keymap.set('n', 'gr', function()
  require('telescope.builtin').lsp_references()
end)
vim.keymap.set('n', '<leader>rn', function()
  vim.lsp.buf.rename()
end)
vim.keymap.set('n', '<leader>ca', function()
  vim.lsp.buf.code_action()
end)

local capabilities = blink.get_lsp_capabilities(vim.lsp.capabilities)

local function on_attach(lsp_client, buffer_number) end

nvim_lsp.add_server({
  name = 'lua-language-server',
  filetypes = {
    'lua',
  },
  root_markers = {
    '.git',
    '.luacheckrc',
    '.luarc.json',
    '.luarc.jsonc',
    '.stylua.toml',
    'selene.toml',
    'selene.yml',
    'stylua.toml',
  },
  on_file_type = function()
    return {
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
              -- [vim.fn.stdpath('config') .. '/lua'] = true,
              [vim.fn.stdpath('config')] = true,
            },
            preloadFileSize = 5000,
          },
          telemetry = {
            enable = false,
          },
        },
      },
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end,
})

-- https://github.com/neovim/neovim/issues/22744
nvim_lsp.add_server({
  name = 'typescript-language-server',
  filetypes = {
    'javascript',
    'javascript.jsx',
    'javascriptreact',
    'typescript',
    'typescript.tsx',
    'typescriptreact',
  },
  root_markers = {
    '.git',
    'jsconfig.json',
    'package.json',
    'tsconfig.json',
  },
  on_file_type = function()
    return {
      cmd = {
        c.get_component('node-18.19.1').bin('node'),
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
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
})

nvim_lsp.add_server({
  name = 'angular-language-server',
  filetypes = {
    'html',
    'htmlangular',
    'typescript',
    'typescript.tsx',
    'typescriptreact',
  },
  root_markers = {
    'angular.json',
  },
  on_file_type = function(opts)
    local root_dir = opts.root_dir
    local is_angular_project = root_dir ~= nil and utils.fs_exists(root_dir .. '/angular.json')

    if not is_angular_project then
      return
    end

    local project_library_path = c.get_component('angular-language-server').bin()

    return {
      cmd = {
        c.get_component('node-18.19.1').bin('node'),
        c.get_component('angular-language-server').bin('ngserver'),
        '--stdio',
        '--tsProbeLocations',
        project_library_path,
        '--ngProbeLocations',
        project_library_path,
      },
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
})

nvim_lsp.add_server({
  name = 'vscode-json-language-server',
  filetypes = {
    'json',
    'jsonc',
  },
  on_file_type = function()
    return {
      cmd = {
        c.get_component('node-18.19.1').bin('node'),
        c.get_component('vscode-langservers-extracted').bin('vscode-json-language-server'),
        '--stdio',
      },
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
})

nvim_lsp.add_server({
  name = 'emmet-ls',
  filetypes = {
    'astro',
    'css',
    'eruby',
    'html',
    'htmlangular',
    'htmldjango',
    'javascriptreact',
    'less',
    'pug',
    'sass',
    'scss',
    'svelte',
    'typescriptreact',
    'vue',
  },
  on_file_type = function()
    return {
      cmd = {
        c.get_component('node-16.14.2').bin('node'),
        c.get_component('emmet-ls').bin('emmet-ls'),
        '--stdio',
      },
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
})

nvim_lsp.add_server({
  name = 'bash-language-server',
  filetypes = {
    'sh',
    'bash',
    'zsh',
  },
  on_file_type = function()
    return {
      cmd = {
        c.get_component('node-16.14.2').bin('node'),
        c.get_component('bash-language-server').bin('bash-language-server'),
        'start',
      },
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
})

nvim_lsp.add_server({
  name = 'gopls',
  filetypes = {
    'go',
    'gomod',
    'gotmpl',
    'gowork',
  },
  on_file_type = function()
    return {
      cmd = {
        c.get_component('gotools').bin('gopls'),
      },
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
})

nvim_lsp.start_servers()

function get_current_script_path()
  local current_stack_info = debug.getinfo(2, "S") -- Level 2 is the caller
  if current_stack_info and current_stack_info.source ~= "=[C]" then
    -- Remove the leading '@' if present, which indicates a loaded file
    return (string.sub(current_stack_info.source, 1, 1) == "@" and string.sub(current_stack_info.source, 2) or current_stack_info.source)
  end
  return nil
end
-- P(get_current_script_path())
