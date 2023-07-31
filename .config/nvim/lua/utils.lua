local c = require('components')

local cli_and = function(commands_table)
  return table.concat(commands_table, ' && ')
end

local cli_pipe = function(commands_table)
  return table.concat(commands_table, ' | ')
end

local install_node = function(params)
  local node_binaries_directory = '/bin'
  local version = params.version

  c.add_component({
    name = 'node-' .. version,
    binaries_directory = node_binaries_directory,
    install_script = function()
      return cli_pipe({
        'curl -L https://nodejs.org/download/release/v' .. version .. '/node-v' .. version .. '-linux-x64.tar.gz',
        'tar -xz --strip-components=1',
      })
    end,
  })
end

local clone_git_repo = function(params)
  local url = params.url
  local commit = params.commit
  local tag = params.tag

  if commit ~= nil then
    return 'git clone ' .. url .. ' . && git reset --hard ' .. commit
  end

  if tag ~= nil then
    return 'git clone --depth 1 --branch ' .. tag .. ' ' .. url .. ' .'
  end
end

local load_plugin = function(name)
  local path = c.get_component(name).bin('')
  local rtp = path:sub(1, string.len(path) - 1)
  local after = rtp .. '/after'
  local doc = rtp .. '/doc'
  -- local after = c.get_component(name).bin('after')
  -- local doc = c.get_component(name).bin('doc')
  -- local files = vim.fn.glob(path .. "*")
  -- vim.cmd("runtime! " .. rtp .. '/*')
  -- vim.api.nvim_load_runtime(rtp, name)

  vim.opt.rtp:append(rtp)

  local after_stat = vim.loop.fs_stat(after)
  if after_stat and after_stat.type == 'directory' then
    vim.opt.rtp:append(after)
  end

  local doc_stat = vim.loop.fs_stat(doc)
  if doc_stat and doc_stat.type == 'directory' then
    vim.cmd("silent! execute 'helptags' '" .. doc .. "/'")
  end
end

return {
  cli_and = cli_and,
  cli_pipe = cli_pipe,
  install_node = install_node,
  clone_git_repo = clone_git_repo,
  load_plugin = load_plugin,
}
