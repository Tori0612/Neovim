-- @p lua/lsp/start.lua
local servers = { "lua_ls", "ts_ls", "pyright", "gopls", "vimls", "bashls" }
local capabilities = require("helpers.capabilities").get_capabilities()

for _, server in ipairs(servers) do
  local status_ok, config = pcall(require, "servers." .. server)
  if status_ok then
    config.capabilities = capabilities
    vim.lsp.config(server, config)
    vim.lsp.enable(server)
  else
    vim.notify("Could not find lua/servers/" .. server .. ".lua", vim.log.levels.ERROR)
  end
end
