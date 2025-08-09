-- vim.opt.rtp:append(vim.fn.stdpath('config') .. '/plugins/components')
local NVIM_CONFIG_ROOT = require('config').NVIM_CONFIG_ROOT

local components_path = NVIM_CONFIG_ROOT .. '/components'
local components_plugin_url = 'https://github.com/v-l-a-d-i-m-i-r/nvim-components'
local components_plugin_commit = '21711de1320811f0ccdd67789a945c6f56edf718'
-- local components_plugin_path = '/data/projects/nvim-components'
local components_plugin_path = components_path .. '/components-nvim-' .. components_plugin_commit

if not (vim.uv or vim.loop).fs_stat(components_plugin_path) then
  local command = {
    'git clone ' .. components_plugin_url .. ' ' .. components_plugin_path,
    'cd ' .. components_plugin_path,
    'git reset --hard ' .. components_plugin_commit,
  }

  vim.cmd('! ' .. table.concat(command, ' && '))
end

vim.opt.rtp:append(components_plugin_path)

local c = require('components')
local u = require('components.utils')
local utils = require('utils')
local add_nodejs = utils.install_node

c.setup({
  components_path = components_path,
  lazy_install = true,
})

-- Binaries --

add_nodejs({
  version = '16.14.2',
})

add_nodejs({
  version = '18.19.1',
})

c.add_component({
  name = 'yarn',
  binaries_directory = '/node_modules/.bin',
  install_script = function()
    local version = '1.22.18'
    local node = c.get_component('node-16.14.2').bin('node')
    local npm = c.get_component('node-16.14.2').bin('npm')

    return u.cli_and({
      'npm init -y',
      node .. ' ' .. npm .. ' install --save-exact yarn@' .. version,
    })
  end,
})

c.add_component({
  name = 'go',
  binaries_directory = '/bin',
  install_script = function()
    local version = '1.18.2'

    return u.cli_pipe({
      'curl -L https://go.dev/dl/go' .. version .. '.linux-amd64.tar.gz',
      'tar -xz --strip=1',
    })
  end,
})

c.add_component({
  name = 'gotools',
  binaries_directory = '/bin',
  install_script = function()
    local version = '0.12.4'

    return u.cli_and({
      'git clone --depth 1 --branch gopls/v' .. version .. '  https://github.com/golang/tools.git .',
      'cd ./gopls',
      c.get_component('go').bin('go') .. ' build -o ../bin/gopls',
    })
  end,
})

c.add_component({
  name = 'typescript-language-server',
  binaries_directory = '/node_modules/.bin',
  install_script = function()
    local version = '4.3.4'
    local node = c.get_component('node-18.19.1').bin('node')
    local yarn = c.get_component('yarn').bin('yarn')

    return u.cli_and({
      'npm init -y',
      node .. ' ' .. yarn .. ' add typescript-language-server@' .. version .. ' typescript@5.7.2',
    })
  end,
})

c.add_component({
  name = 'angular-language-server',
  binaries_directory = '/node_modules/.bin',
  install_script = function()
    local version = '17.3.1'
    local node = c.get_component('node-18.19.1').bin('node')
    local yarn = c.get_component('yarn').bin('yarn')

    return u.cli_and({
      'npm init -y',
      node .. ' ' .. yarn .. ' add @angular/language-server@' .. version .. ' typescript@5.7.2',
    })
  end,
})

c.add_component({
  name = 'vscode-langservers-extracted',
  binaries_directory = '/node_modules/.bin',
  install_script = function()
    local version = '4.8.0'
    local path = c.get_component('node-16.14.2').bin('') .. ':$PATH'

    return u.cli_and({
      'npm init -y',
      'PATH=' .. path .. ' npm install --save-exact ' .. 'vscode-langservers-extracted@' .. version,
    })
  end,
})

c.add_component({
  name = 'emmet-language-server',
  binaries_directory = '/node_modules/.bin',
  install_script = function()
    local version = '2.6.1'
    local node = c.get_component('node-18.19.1').bin('node')
    local yarn = c.get_component('yarn').bin('yarn')

    return u.cli_and({
      'npm init -y',
      node .. ' ' .. yarn .. ' add @olrtg/emmet-language-server@' .. version .. ' typescript@5.7.2',
    })
  end,
})

c.add_component({
  name = 'bash-language-server',
  binaries_directory = '/node_modules/.bin',
  install_script = function()
    -- local version = '3.0.3'
    local version = '5.4.3'
    local node = c.get_component('node-18.19.1').bin('node')
    local yarn = c.get_component('yarn').bin('yarn')

    return u.cli_and({
      'npm init -y',
      node .. ' ' .. yarn .. ' add bash-language-server@' .. version,
    })
  end,
})

c.add_component({
  name = 'lua-language-server',
  binaries_directory = '/bin',
  install_script = function()
    local version = '3.13.9'

    return u.cli_pipe({
      'curl -L https://github.com/LuaLS/lua-language-server/releases/download/'
        .. version
        .. '/lua-language-server-'
        .. version
        .. '-linux-x64.tar.gz',
      'tar -xz',
    })
  end,
})

-- Nvim Plugin Dependencies --

c.add_component({
  name = 'plenary',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/nvim-lua/plenary.nvim',
      tag = 'v0.1.4',
    })
  end,
  on_init = function()
    c.load_plugin('plenary')
  end,
})

c.add_component({
  name = 'nvim-web-devicons',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/nvim-tree/nvim-web-devicons',
      commit = 'c90dee4e930ab9f49fa6d77f289bff335b49e972',
    })
  end,
  on_init = function()
    c.load_plugin('nvim-web-devicons')
  end,
})

-- c.add_component({
--   name = 'dressing.nvim',
--   install_script = function()
--     return u.clone_git_repo({
--       url = 'https://github.com/stevearc/dressing.nvim',
--       tag = 'v3.1.1',
--     })
--   end,
--   on_init = function()
--     c.load_plugin('dressing.nvim')
--     require('dressing-setup')
--   end,
-- })

c.add_component({
  name = 'nui.nvim',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/MunifTanjim/nui.nvim',
      tag = '0.4.0',
    })
  end,
  on_init = function()
    c.load_plugin('nui.nvim')
  end,
})

-- Nvim Plugins

c.add_component({
  name = 'lualine',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/nvim-lualine/lualine.nvim',
      commit = 'de2c4beaf50552647273b5eaa33095e90a6d00a0',
    })
  end,
  on_init = function()
    c.load_plugin('lualine')
    require('lualine-setup')
  end,
})

c.add_component({
  name = 'indent_blankline',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/lukas-reineke/indent-blankline.nvim',
      tag = 'v2.20.6',
    })
  end,
  on_init = function()
    c.load_plugin('indent_blankline')
    require('indent-blankline-setup')
  end,
})

c.add_component({
  name = 'nvim-highlight-colors',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/brenoprata10/nvim-highlight-colors',
      commit = 'b42a5ccec7457b44e89f7ed3b3afb1b375bb2093',
    })
  end,
  on_init = function()
    c.load_plugin('nvim-highlight-colors')
    require('nvim-highlight-colors').setup({})
  end,
})

c.add_component({
  name = 'luasnip',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/L3MON4D3/LuaSnip',
      commit = '51ebb4b6637290e1b8e0fb0d6f38b605d3c24940',
    })
  end,
  on_init = function()
    c.load_plugin('luasnip')
    require('luasnip-setup')
  end,
})

c.add_component({
  name = 'blink.cmp',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/Saghen/blink.cmp',
      tag = 'v1.1.1',
    })
  end,
  on_init = function()
    c.load_plugin('blink.cmp')
    require('blink-setup')
  end,
})

c.add_component({
  name = 'blink-cmp-avante',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/Kaiser-Yang/blink-cmp-avante',
      tag = 'v0.1.0',
    })
  end,
  on_init = function()
    c.load_plugin('blink-cmp-avante')
  end,
})

-- https://github.com/Kaiser-Yang/blink-cmp-avante

c.add_component({
  name = 'playground',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/nvim-treesitter/playground',
      commit = '01c27f37a1f067200680cacfb7b96f5ad2fa5cd6',
    })
  end,
  on_init = function()
    c.load_plugin('playground')
  end,
})

c.add_component({
  name = 'nvim-treesitter-context',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/nvim-treesitter/nvim-treesitter-context',
      -- commit = '05aa871a41078ae82158a37940972f6fea057c01',
      -- commit = '2aba92ceb1479485953007f4d5adf34d0b66917e', -- last used with nvim 0.10
      commit = '93b29a32d5f4be10e39226c6b796f28d68a8b483',
    })
  end,
  on_init = function()
    c.load_plugin('nvim-treesitter-context')
  end,
})

c.add_component({
  name = 'nvim-treesitter',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/nvim-treesitter/nvim-treesitter',
      -- tag = 'v0.9.2', -- last used with nvim 0.10
      tag = 'v0.9.3',
    })
  end,
  on_init = function()
    c.load_plugin('nvim-treesitter')
    require('nvim-treesitter-setup')
  end,
})

c.add_component({
  name = 'nvim-tree',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/nvim-tree/nvim-tree.lua',
      -- commit = 'f5d970d4506f385b29534252d8c15a782fa53034', -- last used with nvim 0.10
      tag = 'v1.11.0',
    })
  end,
  on_init = function()
    c.load_plugin('nvim-tree')
    require('nvim-tree-setup')
  end,
})

c.add_component({
  name = 'trouble.nvim',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/folke/trouble.nvim',
      -- tag = 'v2.8.0', -- last used with nvim 0.10
      tag = 'v3.7.1',
    })
  end,
  on_init = function()
    c.load_plugin('trouble.nvim')
    require('trouble-config')
  end,
})

c.add_component({
  name = 'telescope-fzf-native.nvim',
  install_script = function()
    return u.cli_and({
      u.clone_git_repo({
        url = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
        commit = '6a33ecefa9b3d9ade654f9a7a6396a00c3758ca6',
      }),
      u.cli_and({
        'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5',
        'cmake --build build --config Release',
      }),
    })
  end,
  on_init = function()
    c.load_plugin('telescope-fzf-native.nvim')
  end,
})

c.add_component({
  name = 'telescope-live-grep-args.nvim',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/nvim-telescope/telescope-live-grep-args.nvim',
      commit = '0f75ea809c46af8997c64f49c52e3c641d887885',
    })
  end,
  on_init = function()
    c.load_plugin('telescope-live-grep-args.nvim')
  end,
})

c.add_component({
  name = 'telescope',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/nvim-telescope/telescope.nvim',
      tag = '0.1.8',
    })
  end,
  on_init = function()
    c.load_plugin('telescope')
    require('telescope-setup')
  end,
})

c.add_component({
  name = 'diffview.nvim',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/v-l-a-d-i-m-i-r/diffview.nvim',
      commit = '6809cc581423ae8d3c8ce5d7a05414b8f1265acd',
      -- commit = '6ca4cce071d527fa16c27781f98b843774ae84a7', -- last used with nvim 0.10
      -- commit = '500d8b2013812e05ab87db83a8d22319986519f2', -- diff file not working
      -- commit = 'a111d19ccceac6530448d329c63f998f77b5626e', -- file history does not show the whole history
    })
  end,
  on_init = function()
    c.load_plugin('diffview.nvim')
    require('diffview-setup')
  end,
})

c.add_component({
  name = 'gitsigns',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/lewis6991/gitsigns.nvim',
      tag = 'v0.6',
    })
  end,
  on_init = function()
    c.load_plugin('gitsigns')
    require('gitsigns').setup()
  end,
})

c.add_component({
  name = 'vim-fugitive',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/tpope/vim-fugitive',
      tag = 'v3.7',
    })
  end,
  on_init = function()
    c.load_plugin('vim-fugitive')
  end,
})

c.add_component({
  name = 'conflict-marker.vim',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/rhysd/conflict-marker.vim',
      commit = '11a4d42244755505b66b15cd4496a150432eb5e3',
    })
  end,
  on_init = function()
    c.load_plugin('conflict-marker.vim')
    require('conflict-marker-setup')
  end,
})

c.add_component({
  name = 'vim-repeat',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/tpope/vim-repeat',
      tag = 'v1.2',
    })
  end,
  on_init = function()
    c.load_plugin('vim-repeat')
  end,
})

c.add_component({
  name = 'nvim-autopairs',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/windwp/nvim-autopairs',
      commit = '59df87a84c80a357ca8d8fe86e451b93ac476ccc',
    })
  end,
  on_init = function()
    c.load_plugin('nvim-autopairs')
    require('nvim-autopairs').setup({})
  end,
})

c.add_component({
  name = 'ts_context_commentstring',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/JoosepAlviste/nvim-ts-context-commentstring',
      commit = '1277b4a1f451b0f18c0790e1a7f12e1e5fdebfee',
    })
  end,
  on_init = function()
    c.load_plugin('ts_context_commentstring')
  end,
})

c.add_component({
  name = 'Comment.nvim',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/numToStr/Comment.nvim',
      tag = 'v0.8.0',
    })
  end,
  on_init = function()
    c.load_plugin('Comment.nvim')
    require('comment-setup')
  end,
})

c.add_component({
  name = 'todo-comments.nvim',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/folke/todo-comments.nvim',
      tag = 'v1.1.0',
    })
  end,
  on_init = function()
    c.load_plugin('todo-comments.nvim')
    require('todo-comments').setup()
  end,
})

c.add_component({
  name = 'vim-startuptime',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/dstein64/vim-startuptime',
      tag = 'v4.4.0',
    })
  end,
  on_init = function()
    c.load_plugin('vim-startuptime')
  end,
})

c.add_component({
  name = 'aerial.nvim',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/stevearc/aerial.nvim',
      tag = 'v1.1.0',
    })
  end,
  on_init = function()
    c.load_plugin('aerial.nvim')
    require('aerial-setup')
  end,
})

c.add_component({
  name = 'nvim-lsp',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/v-l-a-d-i-m-i-r/nvim-lsp',
      commit = '91a89404a41b4a8057e78e4f74aad7037f4e3cb2',
    })
  end,
  on_init = function()
    c.load_plugin('nvim-lsp')
    require('lsp-setup')
  end,
})

c.add_component({
  name = 'vim-tmux-navigator',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/christoomey/vim-tmux-navigator',
      commit = '424b5caa154bff34dc258ee53cec5a8e36cf7ea8',
    })
  end,
  on_init = function()
    c.load_plugin('vim-tmux-navigator')
  end,
})

c.add_component({
  name = 'better-vim-tmux-resizer',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/RyanMillerC/better-vim-tmux-resizer',
      commit = 'a791fe5b4433ac43a4dad921e94b7b5f88751048',
    })
  end,
  on_init = function()
    c.load_plugin('better-vim-tmux-resizer')
  end,
})

c.add_component({
  name = 'render-markdown.nvim',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/MeanderingProgrammer/render-markdown.nvim',
      tag = 'v8.4.0',
    })
  end,
  on_init = function()
    c.load_plugin('render-markdown.nvim')
    require('render-markdown-setup')
  end,
})

c.add_component({
  name = 'avante.nvim',
  install_script = function()
    return u.cli_and({
      u.clone_git_repo({
        url = 'https://github.com/yetone/avante.nvim',
        tag = 'v0.0.23',
      }),
      'make',
    })
  end,
  on_init = function()
    c.load_plugin('avante.nvim')
    require('avante-setup')
  end,
})

c.add_component({
  name = 'nvim-themes',
  install_script = function()
    return u.clone_git_repo({
      url = 'https://github.com/v-l-a-d-i-m-i-r/nvim-themes',
      commit = 'd39fae3f434b9afccb74465a9efc46ddad573c93',
    })
  end,
  on_init = function()
    c.load_plugin('nvim-themes')
    require('colorscheme-setup')
  end,
})

-- vim.opt.rtp:append('/data/projects/nvim-themes')
-- require('colorscheme-setup')
-- vim.opt.rtp:append(vim.fn.stdpath('config') .. '/plugins/components')
