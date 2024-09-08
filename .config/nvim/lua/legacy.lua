c.add_component({
  name = 'diffchar.vim',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/rickhowe/diffchar.vim',
      commit = '1410bef63fb62ef5901b15160e0192352d613a38',
    })
  end,
})

c.add_component({
  name = 'vscode-node-debug2',
  binaries_directory = '/out/src',
  install_script = function()
    local version = '1.43.0'
    local path = c.get_component('node-16.14.2').bin('') .. ':$PATH'

    return cli_and({
      'git clone --depth 1 --branch v' .. version .. ' https://github.com/microsoft/vscode-node-debug2.git .',
      'PATH=' .. path .. ' npm ci',
      'PATH=' .. path .. ' node ./node_modules/.bin/gulp build',
    })
  end,
})

c.add_component({
  name = 'vscode-js-debug',
  binaries_directory = '/',
  install_script = function()
    local version = '1.71.1'
    local path = c.get_component('node-16.14.2').bin('') .. ':$PATH'

    return cli_and({
      'git clone --depth 1 --branch v' .. version .. ' https://github.com/microsoft/vscode-js-debug.git .',
      'PATH=' .. path .. ' npm ci --legacy-peer-deps',
      'PATH=' .. path .. ' npm run compile',
    })
  end,
})

c.add_component({
  name = 'vimspector',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/puremourning/vimspector',
      commit = '4e03d5ea5c2d7efb8d1f5e73dcc917ad53b0bfb9',
    })
  end,
})

c.add_component({
  name = 'nvim-dap',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/mfussenegger/nvim-dap',
      tag = '0.6.0',
    })
  end,
})

c.add_component({
  name = 'nvim-dap-ui',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/rcarriga/nvim-dap-ui',
      tag = 'v3.8.3',
    })
  end,
})

c.add_component({
  name = 'nvim-dap-vscode-js',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/mxsdev/nvim-dap-vscode-js',
      tag = 'v1.1.0',
    })
  end,
})

c.add_component({
  name = 'darkplus.nvim',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/LunarVim/darkplus.nvim',
      commit = '2584cdeefc078351a79073322eb7f14d7fbb1835',
    })
  end,
})

load_plugin('ts_context_commentstring')
load_plugin('Comment.nvim')
load_plugin('nvim-cmp')
load_plugin('LuaSnip')
load_plugin('cmp-buffer')
load_plugin('cmp-cmdline')
load_plugin('cmp-nvim-lsp')
load_plugin('cmp-nvim-lsp')
load_plugin('cmp-path')
load_plugin('cmp_luasnip')
load_plugin('conflict-marker.vim')
load_plugin('darkplus.nvim')
load_plugin('diffchar.vim')
load_plugin('diffview.nvim')
load_plugin('gitsigns.nvim')
load_plugin('indent-blankline.nvim')
load_plugin('lsp_signature.nvim')
load_plugin('lualine.nvim')
load_plugin('nvim-autopairs')
load_plugin('nvim-cmp')
load_plugin('nvim-colorizer.lua')
load_plugin('nvim-dap')
load_plugin('nvim-dap-ui')
load_plugin('nvim-dap-vscode-js')
load_plugin('nvim-lspconfig')
load_plugin('nvim-tree.lua')
load_plugin('nvim-treesitter')
load_plugin('nvim-treesitter-context')
load_plugin('nvim-web-devicons')
load_plugin('playground')
load_plugin('plenary.nvim')
load_plugin('telescope-fzf-native.nvim')
load_plugin('telescope-live-grep-args.nvim')
load_plugin('telescope.nvim')
load_plugin('todo-comments.nvim')
load_plugin('trouble.nvim')
load_plugin('vim-fugitive')
load_plugin('vim-repeat')
load_plugin('vimspector')
load_plugin('vim-startuptime')
load_plugin('aerial.nvim')
load_plugin('nvim-themes')

lspconfig.eslint.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    c.get_component('node-16.14.2').bin('node'),
    -- c.get_component("vscode-langservers-extracted-4.7.0").bin("vscode-eslint-language-server"),
    c.get_component('vscode-langservers-extracted-4.4.0').bin('vscode-eslint-language-server'),
    '--stdio',
  },
  settings = {
    cmd = {
      shell = '/bin/bash',
      arguments = {
        '-ce',
        'PATH=' .. c.get_component('node-16.14.2').bin('') .. ':$PATH" "$@"',
      },
    },
  },
  handlers = {
    ['eslint/noLibrary'] = function()
      return {}
    end,
  },
  -- root_dir = function() return vim.loop.cwd() end,
})

lspconfig.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    c.get_component('node-16.14.2').bin('node'),
    c.get_component('vscode-langservers-extracted-4.7.0').bin('vscode-css-language-server'),
    '--stdio',
  },
})

-- Vertical allign center after the scrolling
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '{', '{zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '}', '}zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'n', 'nzz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '*', '*zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '#', '#zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'g*', 'g*zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'g#', 'g#zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-o>', '<C-o>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-i>', '<C-i>zz', { noremap = true, silent = true })
