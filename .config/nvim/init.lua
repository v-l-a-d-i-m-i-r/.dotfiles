require("settings")
require("mappings")
require("plugins")
require("darkplus-theme")
require("intellisense")

vim.cmd[[let NERDTreeShowHidden=1]]
     vim.cmd[[let NERDTreeShowLineNumbers=1]]
-- syntax on
require('lualine').setup {
  options = { 
    section_separators = '',
    component_separators = '',
    theme = "codedark"
  },
}
require("bufferline").setup{
  options = {
    numbers = "buffer_id",
    show_buffer_icons = false,
    show_close_icon = false,
  },
}

require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    "lua",
    "rust",
    "typescript",
    "javascript",
    "tsx",
    "bash",
    "fish",
    "toml",
    "json",
    "yaml",
    "vim",
    "dockerfile",
    "markdown"
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require('colorizer').setup()


