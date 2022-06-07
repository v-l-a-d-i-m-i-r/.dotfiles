local c = require("components");

c.setup({
  path = os.getenv("HOME") .. "/.config/nvim/components",
})

local node_binaries_directory = "/bin"
local install_node = function (params)
  local version = params.version

  return "curl -L https://nodejs.org/download/release/v" .. version .. "/node-v" .. version .. "-linux-x64.tar.gz | tar -xz --strip-components=1"
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

c.add_component({
  name = "go",
  version = "1.18.2",
  binaries_directory = "/bin",
  install_script = function (params)
    local version = params.version

    return "curl -L https://go.dev/dl/go" .. version .. ".linux-amd64.tar.gz | tar -xz --strip=1"
  end,
})

c.add_component({
  name = "yarn",
  version = "1.22.18",
  binaries_directory = "/node_modules/.bin",
  install_script = function (params)
    local version = params.version
    local name = params.name
    local npm = c.get_component("node:16.14.2").bin("npm")

    return npm .. " install --save-exact " .. name .. "@" .. version
  end
})

c.add_component({
  name = "typescript-language-server",
  version = "0.10.1",
  binaries_directory = "/node_modules/.bin",
  install_script = function (params)
    local version = params.version
    local name = params.name
    local node = c.get_component("node:16.14.2").bin("node")
    local yarn = c.get_component("yarn:1.22.18").bin("yarn")

    return node .. " " .. yarn .. " add " .. name .. "@" .. version .. " typescript@4.6.4"
  end
})

c.add_component({
  name = "vscode-langservers-extracted",
  version = "4.2.1",
  binaries_directory = "/node_modules/.bin",
  install_script = function (params)
    local version = params.version
    local name = params.name
    local node = c.get_component("node:16.14.2").bin("node")
    local npm = c.get_component("node:16.14.2").bin("npm")

    return node .. " " .. npm .. " install --save-exact " .. name .. "@" .. version
  end
})

c.add_component({
  name = "bash-language-server",
  version = "3.0.3",
  binaries_directory = "/node_modules/.bin",
  install_script = function (params)
    local version = params.version
    local name = params.name
    local node = c.get_component("node:14.17.5").bin("node")
    local yarn = c.get_component("yarn:1.22.18").bin("yarn")

    return node .. " " .. yarn .. " add " .. name .. "@" .. version
  end
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

c.add_component({
  name = "gopls",
  version = "0.8.4",
  binaries_directory = "/bin",
  install_script = function (params)
    local version = params.version
    local command_table = {
      "git clone --depth 1 --branch gopls/v" ..version .. "  https://github.com/golang/tools.git .",
      "cd ./gopls",
      c.get_component("go:1.18.2").bin("go") .. " build -o ../bin/gopls",
    }
    return table.concat(command_table, " && ")
  end,
})
