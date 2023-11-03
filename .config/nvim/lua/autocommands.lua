local c = require('components')
local env = require('env')

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '.zshrc', '*.zsh' },
  callback = function()
    vim.cmd('set filetype=bash')
  end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '.Xresources.*' },
  callback = function()
    vim.cmd('set filetype=xdefaults')
  end,
})

vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  pattern = { '*' },
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 500 })
  end,
})

-- https://github.com/gotbletu/shownotes/blob/master/vim_neovim_manpager.md
vim.cmd([[
  augroup manlaunchtoc
    autocmd!
    if has('nvim')
      autocmd FileType man
        \ call man#show_toc() |
        \ setlocal laststatus=0 nonumber norelativenumber |
        \ nnoremap <buffer> l <Enter> |
        \ wincmd H |
        \ vert resize 35 |
        \ wincmd p
    endif
  augroup end
]])

-- https://vi.stackexchange.com/questions/6749/after-copying-a-visual-selection-return-to-original-location
local cursor_position

vim.api.nvim_create_autocmd({ 'VimEnter', 'CursorMoved' }, {
  pattern = { '*' },
  callback = function()
    cursor_position = vim.fn.getpos('.')
  end,
})
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  pattern = { '*' },
  callback = function()
    local operator = vim.v.event.operator

    if operator == 'y' then
      vim.fn.setpos('.', cursor_position)
    end
  end,
})

vim.api.nvim_create_autocmd('Signal', {
  pattern = 'SIGUSR1',
  callback = function()
    vim.cmd('luafile' .. env.NVIM_CONFIG_ROOT .. '/lua/colorscheme-setup.lua')
  end,
})

-- https://github.com/neovim/nvim-lspconfig/issues/1659
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function()
    vim.api.nvim_create_autocmd('BufDelete', {
      buffer = vim.api.nvim_get_current_buf(),
      callback = function(opts)
        require('trouble').close()
        vim.cmd('NvimTreeClose')

        local bufnr = opts.buf
        local clients = vim.lsp.buf_get_clients(bufnr)
        for client_id, _ in pairs(clients) do
          vim.lsp.buf_detach_client(bufnr, client_id)
        end
      end,
    })
  end,
})

-- vim.api.nvim_create_autocmd('BufWritePre', {
--   pattern = '*.go',
--   callback = function()
--     vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
--     -- vim.api.nvim_command('write')
--   end
-- })

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.go',
  callback = function()
    local gopls = c.get_component('gotools').bin('gopls')
    local gofmt = c.get_component('go-1.18.2').bin('gofmt')
    local current_buffer_path = vim.fn.expand('%:p')

    vim.cmd('silent !' .. gopls .. ' imports -w ' .. current_buffer_path)
    vim.cmd('silent !' .. gofmt .. ' -w ' .. current_buffer_path)
  end,
})
