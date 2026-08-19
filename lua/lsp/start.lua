-- @p lua/lsp/start.lua
local servers = { "lua_ls", "ts_ls", "pyright", "gopls", "vimls", "bashls",
  "clangd", "tinymist", 'zls', 'lemminx', 'html' }
local capabilities = require("lsp.capabilities").get_capabilities()
local is_windows = vim.fn.has("win32") == 1

for _, server in ipairs(servers) do
  local status_ok, config = pcall(require, "servers." .. server)
  if status_ok then
    config.capabilities = capabilities
    vim.lsp.config(server, config)
    vim.lsp.enable(server)
  else
    if not is_windows then
      vim.notify("Could not find lua/servers/" .. server .. ".lua", vim.log.levels.ERROR)
    else
      vim.notify("Could not find lua\\servers\\" .. server .. ".lua", vim.log.levels.ERROR)
    end
  end
end
