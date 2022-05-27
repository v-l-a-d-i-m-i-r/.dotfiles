local C = {}
local params = {}
local components_names_list = {}
local components = {}

local function check_file_exists(path)
  if os.execute("! test -f " .. path) ~= 0 then
    return true
  else
    return false
  end
end

local function check_directory_exists(path)
  if os.execute("! test -d " .. path) ~= 0 then
    return true
  else
    return false
  end
end

local function set_component(name, component)
  table.insert(components_names_list, name)
  components[name] = component
end

C.setup = function(p)
  params = p
end

C.install_components = function()
  for _, component_name in ipairs(components_names_list) do
    local component = components[component_name]
    local is_component_installed = component.check_installed()

    if not is_component_installed then
      print("Installing " .. component_name)
      component.install()
    else
      print(component_name .. " already installed")
    end
  end
end

C.get_component = function(name)
  return components[name]
end

C.add_node = function(options)
  local version = options.version
  local key = "node:" .. version
  local installation_path = params.path .. "/" .. key

  local install = function()
    vim.cmd("! mkdir -p " .. installation_path .. " && cd " .. installation_path .. " && curl https://nodejs.org/download/release/v" .. version .. "/node-v" .. version .. "-linux-x64.tar.gz | tar -xz --strip=1")
  end

  local bin = function(binary_name)
    return installation_path .. "/bin/" .. binary_name
  end

  set_component(key, {
    install = install,
    bin = bin,
    check_installed = function()
      return check_file_exists(bin("node"))
    end
  })
end

C.add_component = function(options)
  local version = options.version
  local name = options.name
  local key = name .. ":" .. version
  local installation_path = params.path .. "/" .. key
  local binaries_directory = options.binaries_directory
  local install_script = options.install_script({
    version = version,
  })

  local install = function()
    local command_table = {
      "! mkdir -p " .. installation_path,
      "cd " .. installation_path,
      install_script,
    }
    vim.cmd(table.concat(command_table, " && "))
  end

  local bin = function(binary_name)
    return installation_path .. binaries_directory .. "/" .. binary_name
  end

  set_component(key, {
    install = install,
    bin = bin,
    check_installed = function()
      return check_directory_exists(bin(""))
    end
  })
end

C.add_npm_package = function(options)
  local version = options.version
  local node_version = options.node_version
  local name = options.name .. ":" .. version
  local package_name = options.name .. "@" .. version
  local installation_path = params.path .. "/" .. name .. "/"

  local install = function()
    local node = C.get_component("node:" .. node_version).bin("node")
    local npm = C.get_component("node:" .. node_version).bin("npm")

    vim.cmd("! mkdir -p " .. installation_path .. " && cd " .. installation_path .. " && " .. node .. " " .. npm .. " install --save-exact " .. package_name)
  end

  local bin = function(binary_name)
    return installation_path .. "node_modules/.bin/" .. binary_name
  end

  set_component(name, {
    install = install,
    bin = bin,
    check_installed = function()
      return check_directory_exists(bin(""))
    end
  })
end

C.add_yarn_package = function(options)
  local version = options.version
  local node_version = options.node_version
  local yarn_version = options.yarn_version
  local name = options.name .. ":" .. version
  local installation_path = params.path .. "/" .. name .. "/"
  local packages_to_install = options.name .. "@" .. version

  for _, dependency in ipairs(options.dependencies or {}) do
    packages_to_install = packages_to_install .. " " .. dependency.name .. "@" .. dependency.version
  end

  local install = function()
    local node = C.get_component("node:" .. node_version).bin("node")
    local yarn = C.get_component("yarn:" .. yarn_version).bin("yarn")

    vim.cmd("! mkdir -p " .. installation_path .. " && cd " .. installation_path .. " && " .. node .. " " .. yarn .. " add " .. packages_to_install)
  end

  local bin = function(binary_name)
    return installation_path .. "node_modules/.bin/" .. binary_name
  end

  set_component(name, {
    install = install,
    bin = bin,
    check_installed = function()
      return check_directory_exists(bin(""))
    end
  })
end

return C
