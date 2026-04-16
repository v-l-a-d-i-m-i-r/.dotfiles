local treesitter = require('nvim-treesitter')
local treesitter_config = require('nvim-treesitter.config')

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    -- Enable treesitter highlighting and disable regex syntax
    pcall(vim.treesitter.start)
    -- Enable treesitter-based indentation
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

local ensure_installed = {
  'angular',
  'bash',
  'c',
  'css',
  'csv',
  'diff',
  'dockerfile',
  'fish',
  'go',
  'gomod',
  'gowork',
  'html',
  'http',
  'javascript',
  'json',
  'lua',
  'make',
  'markdown',
  'query',
  'rust',
  'scss',
  'terraform',
  'tmux',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc', -- help
  'yaml',
}

local already_installed = treesitter_config.get_installed()

local parsers_to_install = vim
  .iter(ensure_installed)
  :filter(function(parser)
    return not vim.tbl_contains(already_installed, parser)
  end)
  :totable()

treesitter.install(parsers_to_install)

treesitter.setup()
