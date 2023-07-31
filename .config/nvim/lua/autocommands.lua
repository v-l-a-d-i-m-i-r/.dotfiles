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
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 750 })
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
