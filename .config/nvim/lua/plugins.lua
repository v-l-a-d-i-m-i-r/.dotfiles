-- :PlugSnapshot plug.snapshot
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-- Debugger
Plug 'puremourning/vimspector'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

-- Interface
Plug 'LunarVim/darkplus.nvim' -- replacement for martinsione/darkplus.nvim
Plug 'nvim-lualine/lualine.nvim'
Plug ('akinsho/bufferline.nvim', { ['tag'] = '*' })
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'norcalli/nvim-colorizer.lua'

-- Languages support
Plug 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
Plug 'hrsh7th/nvim-cmp' -- Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip' -- Snippets plugin
Plug ('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

-- File tree
Plug 'kyazdani42/nvim-tree.lua'
Plug 'folke/trouble.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'simrat39/symbols-outline.nvim'

-- Misc
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'tpope/vim-repeat'
Plug 'windwp/nvim-autopairs'
Plug 'gpanders/editorconfig.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'PHSix/faster.nvim'
Plug 'ur4ltz/surround.nvim'
Plug 'phaazon/hop.nvim'

-- Local
Plug '~/.config/nvim/plugins/components'

vim.call('plug#end')
