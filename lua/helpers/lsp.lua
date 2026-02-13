-- @p lua/helpers/lsp.lua
-- This helper can and it's being used by common lsps (defined in .env.example)
-- it is pretty simple, if you have a path to a lsp defined in .env, the lsp api will use it
-- if not then it will fall back to mason's default, notice that lsp paths should have `_LSP_PATH`
-- at the end of their names, e.g. ZLS_LSP_PATH.
-- Heres a list of implemented ones:
-- @p lua/servers/lua_ls.lua
-- @p lua/servers/basedpyright.lua
-- @p lua/servers/pyright.lua
-- @p lua/servers/rust_analyzer.lua
-- @p lua/servers/zls.lua
-- @p lua/servers/ts_ls.lua
-- @p lua/servers/gopls.lua
-- @p lua/servers/clangd.lua

local M = {}

function M.get_cmd(server_name, default_binary)
    local env_path = os.getenv(server_name:upper() .. "_LSP_PATH")
    if env_path and vim.fn.executable(env_path) == 1 then
      return env_path
    end

    local mason_path = vim.fn.stdpath("data") .. "/mason/bin/" .. default_binary
    if vim.fn.executable(mason_path) == 1 then
        return mason_path
    end

    return default_binary
end

return M
