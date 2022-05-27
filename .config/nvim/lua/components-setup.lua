local c = require("components-plugin");

c.setup({
  path = os.getenv("HOME") .. "/.config/nvim/components",
})

local node_binaries_directory = "/bin"
local install_node = function (params)
  local version = params.version

  return "curl https://nodejs.org/download/release/v" .. version .. "/node-v" .. version .. "-linux-x64.tar.gz | tar -xz --strip=1"
end

c.add_component({
  name = "node",
  version = "16.14.2",
  binaries_directory = node_binaries_directory,
  install_script = install_node,
})

c.add_component({
  name = "node",
  version = "14.17.5",
  binaries_directory = node_binaries_directory,
  install_script = install_node,
})

c.add_npm_package({
  name = "yarn",
  version = "1.22.18",
  node_version = "16.14.2",
})

c.add_yarn_package({
  name = "typescript-language-server",
  version = "0.10.1",
  node_version = "16.14.2",
  yarn_version = "1.22.18",
  dependencies = {
    {
      name = "typescript",
      version = "4.6.4",
    },
  },
})

c.add_npm_package({
  name = "vscode-langservers-extracted",
  version = "4.2.1",
  node_version = "14.17.5",
})

c.add_yarn_package({
  name = "bash-language-server",
  version = "3.0.3",
  node_version = "14.17.5",
  yarn_version = "1.22.18",
})

c.add_component({
  name = "lua-language-server",
  version = "3.2.4",
  binaries_directory = "/bin",
  install_script = function (params)
    local version = params.version

    return "curl -L https://github.com/sumneko/lua-language-server/releases/download/" .. version .. "/lua-language-server-" .. version .. "-linux-x64.tar.gz | tar -xz"
  end,
})

c.add_component({
  name = "vscode-node-debug2",
  version = "1.43.0",
  binaries_directory = "/out/src",
  install_script = function (params)
    local version = params.version
    local command_table = {
      "git clone --depth 1 --branch v" ..version .. " https://github.com/microsoft/vscode-node-debug2.git .",
      c.get_component("node:16.14.2").bin("npm") .. " ci",
      c.get_component("node:16.14.2").bin("node") .. " ./node_modules/.bin/gulp build"
    }
    return table.concat(command_table, " && ")
  end,
})
