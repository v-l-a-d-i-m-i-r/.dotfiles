local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug ('preservim/nerdtree', { on = 'NERDTreeToggle' })
Plug 'ryanoasis/vim-devicons'
Plug 'navarasu/onedark.nvim'
Plug ('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug 'EdenEast/nightfox.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'pappasam/papercolor-theme-slim'
Plug ('akinsho/bufferline.nvim', { ['tag'] = '*' })
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'martinsione/darkplus.nvim'
Plug 'PHSix/faster.nvim'

-- Intellisense
Plug 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
Plug 'hrsh7th/nvim-cmp' -- Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip' -- Snippets plugin

vim.call('plug#end')
