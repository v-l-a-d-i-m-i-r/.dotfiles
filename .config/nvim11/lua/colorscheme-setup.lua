-- start colors
vim.cmd('colorscheme nord-simple')
-- end colors

package.loaded['tabline-setup'] = nil
require('tabline-setup').setup()
