-- :PlugSnapshot plug.snapshot
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-- Debugger
Plug 'puremourning/vimspector'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

-- Interface
Plug 'LunarVim/darkplus.nvim' -- replacement for martinsione/darkplus.nvim
Plug 'RRethy/nvim-base16'
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
Plug ('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'simrat39/symbols-outline.nvim'

-- Git
Plug 'sindrets/diffview.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
Plug 'rhysd/conflict-marker.vim'

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
Plug 'folke/todo-comments.nvim'
Plug 'karb94/neoscroll.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'chentoast/marks.nvim'

-- Local
Plug '~/.config/nvim/plugins/components'
Plug '~/.config/nvim/plugins/themes'

vim.call('plug#end')
