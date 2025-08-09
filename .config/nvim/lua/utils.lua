local c = require('components')
local u = require('components.utils')
local config = require('config')

local install_node = function(params)
  local node_binaries_directory = '/bin'
  local version = params.version

  c.add_component({
    name = 'node-' .. version,
    binaries_directory = node_binaries_directory,
    install_script = function()
      return u.cli_pipe({
        'curl -L https://nodejs.org/download/release/v'
          .. version
          .. '/node-v'
          .. version
          .. '-'
          .. config.NODEJS_ARCH
          .. '.tar.gz',
        'tar -xz --strip-components=1',
      })
    end,
  })
end

local function fs_exists(path)
  if path == nil then
    return false
  end

  return vim.fn.filereadable(path) == 1
end

return {
  install_node = install_node,
  fs_exists = fs_exists,
}
