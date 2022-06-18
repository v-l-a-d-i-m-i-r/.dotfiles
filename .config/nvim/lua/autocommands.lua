vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { ".zshrc" },
  callback = function()
    vim.cmd "set filetype=bash"
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = { "*" },
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 1000 })
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
