vim.opt.rtp:append(vim.fn.stdpath('config') .. '/plugins/components')

local c = require('components')
local utils = require('utils')

local cli_and = utils.cli_and
local cli_pipe = utils.cli_pipe
local clone_git_repo = utils.clone_git_repo
local add_nodejs = utils.install_node
local load_plugin = utils.load_plugin

c.setup({
  path = vim.fn.stdpath('config') .. '/components',
})

add_nodejs({
  version = '16.14.2',
})

add_nodejs({
  version = '14.17.5',
})

add_nodejs({
  version = '18.17.1',
})

c.add_component({
  name = 'go',
  binaries_directory = '/bin',
  install_script = function()
    local version = '1.18.2'

    return cli_pipe({
      'curl -L https://go.dev/dl/go' .. version .. '.linux-amd64.tar.gz',
      'tar -xz --strip=1',
    })
  end,
})

c.add_component({
  name = 'yarn',
  binaries_directory = '/node_modules/.bin',
  install_script = function()
    local version = '1.22.18'
    local node = c.get_component('node-16.14.2').bin('node')
    local npm = c.get_component('node-16.14.2').bin('npm')

    return node .. ' ' .. npm .. ' install --save-exact yarn@' .. version
  end,
})

c.add_component({
  name = 'typescript-language-server',
  binaries_directory = '/node_modules/.bin',
  install_script = function()
    local version = '4.3.0'
    local node = c.get_component('node-18.17.1').bin('node')
    local yarn = c.get_component('yarn').bin('yarn')

    return node .. ' ' .. yarn .. ' add typescript-language-server@' .. version .. ' typescript@4.6.4'
  end,
})

c.add_component({
  name = 'vscode-langservers-extracted',
  binaries_directory = '/node_modules/.bin',
  install_script = function()
    local version = '4.4.0'
    local path = c.get_component('node-16.14.2').bin('') .. ':$PATH'

    return 'PATH=' .. path .. ' npm install --save-exact ' .. 'vscode-langservers-extracted@' .. version
  end,
})

c.add_component({
  name = 'emmet-ls',
  binaries_directory = '/node_modules/.bin',
  install_script = function()
    local version = '0.3.0'
    local path = c.get_component('node-16.14.2').bin('') .. ':$PATH'

    return 'PATH=' .. path .. ' npm install --save-exact ' .. 'emmet-ls@' .. version
  end,
})

c.add_component({
  name = 'bash-language-server',
  binaries_directory = '/node_modules/.bin',
  install_script = function()
    local version = '3.0.3'
    local node = c.get_component('node-14.17.5').bin('node')
    local yarn = c.get_component('yarn').bin('yarn')

    return node .. ' ' .. yarn .. ' add bash-language-server@' .. version
  end,
})

c.add_component({
  name = 'lua-language-server',
  binaries_directory = '/bin',
  install_script = function()
    local version = '3.7.4'

    return cli_pipe({
      'curl -L https://github.com/LuaLS/lua-language-server/releases/download/'
        .. version
        .. '/lua-language-server-'
        .. version
        .. '-linux-x64.tar.gz',
      'tar -xz',
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
  name = 'gotools',
  binaries_directory = '/bin',
  install_script = function()
    local version = '0.12.4'

    return cli_and({
      'git clone --depth 1 --branch gopls/v' .. version .. '  https://github.com/golang/tools.git .',
      'cd ./gopls',
      c.get_component('go').bin('go') .. ' build -o ../bin/gopls',
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

c.add_component({
  name = 'lualine.nvim',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/nvim-lualine/lualine.nvim',
      commit = 'de2c4beaf50552647273b5eaa33095e90a6d00a0',
    })
  end,
})

c.add_component({
  name = 'bufferline.nvim',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/akinsho/bufferline.nvim',
      tag = 'v4.4.0',
    })
  end,
})

c.add_component({
  name = 'indent-blankline.nvim',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/lukas-reineke/indent-blankline.nvim',
      tag = 'v2.20.6',
    })
  end,
})

c.add_component({
  name = 'nvim-colorizer.lua',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/norcalli/nvim-colorizer.lua',
      commit = '36c610a9717cc9ec426a07c8e6bf3b3abcb139d6',
    })
  end,
})

c.add_component({
  name = 'nvim-lspconfig',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/neovim/nvim-lspconfig',
      tag = 'v0.1.7',
    })
  end,
})

c.add_component({
  name = 'nvim-treesitter',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/nvim-treesitter/nvim-treesitter',
      tag = 'v0.9.0',
    })
  end,
})

c.add_component({
  name = 'playground',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/nvim-treesitter/playground',
      commit = '01c27f37a1f067200680cacfb7b96f5ad2fa5cd6',
    })
  end,
})

c.add_component({
  name = 'nvim-treesitter-context',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/nvim-treesitter/nvim-treesitter-context',
      commit = '05aa871a41078ae82158a37940972f6fea057c01',
    })
  end,
})

c.add_component({
  name = 'nvim-cmp',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/hrsh7th/nvim-cmp',
      tag = 'v0.0.1',
    })
  end,
})

c.add_component({
  name = 'cmp-nvim-lsp',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/hrsh7th/cmp-nvim-lsp',
      commit = '0e6b2ed705ddcff9738ec4ea838141654f12eeef',
    })
  end,
})

c.add_component({
  name = 'cmp-buffer',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/hrsh7th/cmp-buffer',
      commit = '3022dbc9166796b644a841a02de8dd1cc1d311fa',
    })
  end,
})

c.add_component({
  name = 'cmp-path',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/hrsh7th/cmp-path',
      commit = '91ff86cd9c29299a64f968ebb45846c485725f23',
    })
  end,
})

c.add_component({
  name = 'cmp-cmdline',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/hrsh7th/cmp-cmdline',
      commit = '5af1bb7d722ef8a96658f01d6eb219c4cf746b32',
    })
  end,
})

c.add_component({
  name = 'cmp_luasnip',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/saadparwaiz1/cmp_luasnip',
      commit = '18095520391186d634a0045dacaa346291096566',
    })
  end,
})

c.add_component({
  name = 'LuaSnip',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/L3MON4D3/LuaSnip',
      commit = '51ebb4b6637290e1b8e0fb0d6f38b605d3c24940',
    })
  end,
})

c.add_component({
  name = 'nvim-tree.lua',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/nvim-tree/nvim-tree.lua',
      commit = 'f5d970d4506f385b29534252d8c15a782fa53034',
    })
  end,
})

c.add_component({
  name = 'trouble.nvim',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/folke/trouble.nvim',
      tag = 'v2.8.0',
    })
  end,
})

c.add_component({
  name = 'telescope.nvim',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/nvim-telescope/telescope.nvim',
      tag = '0.1.5',
    })
  end,
})

c.add_component({
  name = 'telescope-live-grep-args.nvim',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/nvim-telescope/telescope-live-grep-args.nvim',
      commit = '0f75ea809c46af8997c64f49c52e3c641d887885',
    })
  end,
})

c.add_component({
  name = 'telescope-fzf-native.nvim',
  install_script = function()
    return cli_and({
      clone_git_repo({
        url = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
        commit = '6a33ecefa9b3d9ade654f9a7a6396a00c3758ca6',
      }),
      'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    })
  end,
})

c.add_component({
  name = 'diffview.nvim',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/sindrets/diffview.nvim',
      commit = '6ca4cce071d527fa16c27781f98b843774ae84a7',
      -- commit = '500d8b2013812e05ab87db83a8d22319986519f2', -- diff file not working
      -- commit = 'a111d19ccceac6530448d329c63f998f77b5626e', -- file history does not show the whole history
    })
  end,
})

c.add_component({
  name = 'gitsigns.nvim',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/lewis6991/gitsigns.nvim',
      tag = 'v0.6',
    })
  end,
})

c.add_component({
  name = 'vim-fugitive',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/tpope/vim-fugitive',
      tag = 'v3.7',
    })
  end,
})

c.add_component({
  name = 'conflict-marker.vim',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/rhysd/conflict-marker.vim',
      commit = '11a4d42244755505b66b15cd4496a150432eb5e3',
    })
  end,
})

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
  name = 'nvim-web-devicons',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/nvim-tree/nvim-web-devicons',
      commit = '2a125024a137677930efcfdf720f205504c97268',
    })
  end,
})

c.add_component({
  name = 'plenary.nvim',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/nvim-lua/plenary.nvim',
      tag = 'v0.1.2',
    })
  end,
})

c.add_component({
  name = 'vim-repeat',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/tpope/vim-repeat',
      tag = 'v1.2',
    })
  end,
})

c.add_component({
  name = 'nvim-autopairs',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/windwp/nvim-autopairs',
      commit = '59df87a84c80a357ca8d8fe86e451b93ac476ccc',
    })
  end,
})

c.add_component({
  name = 'ts_context_commentstring',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/JoosepAlviste/nvim-ts-context-commentstring',
      commit = '1277b4a1f451b0f18c0790e1a7f12e1e5fdebfee',
    })
  end,
})

c.add_component({
  name = 'Comment.nvim',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/numToStr/Comment.nvim',
      tag = 'v0.8.0',
    })
  end,
})

c.add_component({
  name = 'todo-comments.nvim',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/folke/todo-comments.nvim',
      tag = 'v1.1.0',
    })
  end,
})

c.add_component({
  name = 'lsp_signature.nvim',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/ray-x/lsp_signature.nvim',
      tag = 'v0.2.0',
    })
  end,
})

c.add_component({
  name = 'vim-startuptime',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/dstein64/vim-startuptime',
      tag = 'v4.4.0',
    })
  end,
})

c.add_component({
  name = 'aerial.nvim',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/stevearc/aerial.nvim',
      tag = 'v1.1.0',
    })
  end,
})

c.add_component({
  name = 'nvim-themes',
  install_script = function()
    return clone_git_repo({
      url = 'https://github.com/v-l-a-d-i-m-i-r/nvim-themes',
      commit = 'fb7c89e28c1784d5c6e1793472d577c67e66d42c',
    })
  end,
})

load_plugin('ts_context_commentstring')
load_plugin('Comment.nvim')
load_plugin('LuaSnip')
load_plugin('cmp-buffer')
load_plugin('cmp-cmdline')
load_plugin('cmp-nvim-lsp')
load_plugin('cmp-nvim-lsp')
load_plugin('cmp-path')
load_plugin('cmp_luasnip')
load_plugin('conflict-marker.vim')
load_plugin('darkplus.nvim')
-- load_plugin("diffchar.vim")
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

-- vim.opt.rtp:append('/data/projects/nvim-themes')
