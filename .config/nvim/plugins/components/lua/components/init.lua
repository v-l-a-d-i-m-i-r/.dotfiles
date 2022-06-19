local md5 = require("md5")

local params = {}
local components_names_list = {}
local components = {}

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

local setup = function(p)
  params = p
end

local install_components = function()
  for _, component_name in ipairs(components_names_list) do
    local component = components[component_name]
    local is_component_installed = component.check_installed()

    if not is_component_installed then
      print("Installing " .. component_name)
      component.clear()
      component.install()
    else
      print(component_name .. " already installed")
    end
  end
end

local get_component = function(name)
  return components[name]
end

local add_component = function(options)
  local version = options.version
  local name = options.name
  local key = name .. "-" .. version
  local binaries_directory = options.binaries_directory
  local install_script = options.install_script({
    version = version,
    name = name,
  })
  local hash = md5.sumhexa(install_script)
  local installation_path = params.path .. "/" .. key .. "-" .. hash

  local install = function()
    local command_table = {
      "! mkdir -p " .. installation_path,
      "cd " .. installation_path,
      install_script,
    }
    vim.cmd(table.concat(command_table, " && "))
  end

  local bin = function(binary_name)
    if (binary_name == nil or binary_name == "") then
      return installation_path .. binaries_directory
    else
      return installation_path .. binaries_directory .. "/" .. binary_name
    end
  end

  local clear = function()
    vim.cmd("! rm -rf " .. installation_path)
  end

  set_component(key, {
    install = install,
    clear = clear,
    bin = bin,
    hash = hash,
    check_installed = function()
      return check_directory_exists(bin(""))
    end
  })
end

return {
  setup = setup,
  install_components = install_components,
  add_component = add_component,
  get_component = get_component,
}
