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

-- vim.cmd([[
--   augroup AutoSaveGroup
--     autocmd!
--     " view files are about 500 bytes
--     " bufleave but not bufwinleave captures closing 2nd tab
--     " nested is needed by bufwrite* (if triggered via other autocmd)
--     " BufHidden for compatibility with `set hidden`
--     autocmd BufWinLeave,BufLeave,BufWritePost,BufHidden,QuitPre ?* nested silent! mkview!
--     autocmd BufWinEnter ?* silent! loadview
--   augroup end
-- ]])
-- vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
--   command = "if mode() != 'c' | checktime | endif",
--   pattern = { "*" },
-- })

