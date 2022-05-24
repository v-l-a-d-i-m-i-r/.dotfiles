local C = {}
local params = {}
local components = {}

-- local handlers = {
--   node = {
--     install = function(component)
--       local version = component.version
--       local name = component.name
--       local path = params.path
--       local download_path = "" .. path .. "" .. name .. ""
--
--       vim.cmd("! mkdir -p " .. download_path .. " && curl https://nodejs.org/download/release/v" .. version .. "/node-v" .. version .. "-linux-x64.tar.gz | tar -xz --strip=1 -C " .. download_path .. "")
--     end
--   },
--   ["npm-package"] = {
--     install = function(component)
--       local version = component.version
--       local name = component.name
--       local path = params.path
--       local install_path = "" .. path .. "" .. name .. ""
--
--       vim.cmd("! mkdir -p " .. install_path .. " && cd " .. install_path .. " && npm init -y && npm i ")
--     end
--   }
-- }

C.setup = function(p)
  params = p
end

C.install_components = function()
  for _, component in pairs(components) do
    component.install()
  end
end

C.add_component = function(comonent)
  local type = comonent.type
  local version = comonent.version
  local name = "" .. type .. ":" .. version .. ""

  components[name] = {
    type = type,
    version = version,
    name = name,
  }
end

C.add_node = function(options)
  local type = "node"
  local version = options.version
  local name = "" .. type .. ":" .. version .. ""

  components[name] = {
    type = type,
    version = version,
    name = name,
    install = function()
      local path = params.path
      local download_path = "" .. path .. "" .. name .. ""

      vim.cmd("! mkdir -p " .. download_path .. " && curl https://nodejs.org/download/release/v" .. version .. "/node-v" .. version .. "-linux-x64.tar.gz | tar -xz --strip=1 -C " .. download_path .. "")
    end
  }
end

C.add_yarn_package = function(options)
  local type = "yarn-package"
  local version = options.version
  local name = "" .. type .. ":" .. version .. ""

  components[name] = {
    type = type,
    install = function()
      print(name)
    end,
  }
end

return C
