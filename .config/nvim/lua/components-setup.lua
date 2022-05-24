local c = require("components-plugin");

c.setup({
  path = os.getenv("HOME") .. "/.config/nvim/components/",
})

-- c.add_component({
--   type = "node",
--   version = "16.15.0",
-- })
--
-- c.add_component({
--   type = "node",
--   version = "18.2.0",
-- })
c.add_node({
  version = "16.15.0",
})

-- c.add_component({
--   type = "yarn-package",
--   node_version = "18.2.0",
--   yarn_version = "1.22.18",
--   name = "typescript-language-server",
--   version = "0.10.1",
--   dependencies = {
--     {
--       name = "typescript",
--       version = "4.6.4",
--     },
--   },
-- })
c.add_yarn_package({
  node_version = "18.2.0",
  yarn_version = "1.22.18",
  name = "typescript-language-server",
  version = "0.10.1",
  dependencies = {
    {
      name = "typescript",
      version = "4.6.4",
    },
  },
})
