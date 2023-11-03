-- start colors
vim.cmd('colorscheme code-dark')
-- end colors

package.loaded['tabline-setup'] = nil
require('tabline-setup').setup()
