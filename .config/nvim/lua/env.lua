local HOME = os.getenv('HOME')
local NVIM_APPNAME = os.getenv('NVIM_APPNAME') or 'nvim'
local NVIM_CONFIG_ROOT = vim.fn.stdpath('config')

return {
  HOME = HOME,
  NVIM_APPNAME = NVIM_APPNAME,
  NVIM_CONFIG_ROOT = NVIM_CONFIG_ROOT,
}
