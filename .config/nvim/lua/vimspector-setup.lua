-- https://github.com/puremourning/vimspector#supported-languages
-- https://dev.to/iggredible/debugging-in-vim-with-vimspector-4n0m
--
-- :VimspectorInstall vscode-node-debug2

vim.g.vimspector_install_gadgets = {
  'vscode-node-debug2',
}

vim.api.nvim_set_keymap('n', '<space>dd', ':call vimspector#Launch()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>dt', ':call vimspector#ToggleBreakpoint()<CR>', { noremap = true, silent = true })
