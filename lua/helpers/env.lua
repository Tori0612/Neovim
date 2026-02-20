-- @p lua/helpers/env.lua
-- This helper looks for a .env file, in a way that you can set things like your python path,
-- which is pretty useful for having different venvs, and also a way to point to your lsps if not,
-- installed with mason, check on @p lua/helpers/lsp.lua to see how to set and get your lsps in .env

local M = {}
local is_windows = vim.fn.has("win32") == 1

function M.load()
  -- Gets the .env on the standard nvim config folder(~/.config/nvim/)
  local env_file = ""
  if not is_windows then
    env_file = vim.fn.stdpath("config") .. "/.env"
  else
    env_file = vim.fn.stdpath("config") .. "\\.env"
  end

  -- if there's no .env then it returns, other implementations have a nice fallback (i believe so)
  if vim.fn.filereadable(env_file) == 0 then
    vim.notify("nvim: .env file not found. Using system defaults.", vim.log.levels.WARN)
    return
  end

  local f = io.open(env_file, "r")
  if not f then return end

  -- ignoring comments and matching whats a key and whats a value, pretty simple actually
  for line in f:lines() do
    if not line:match("^#") and line:match("=") then
      local key, value = line:match("([^=]+)=(.*)")
      if key and value then
        vim.env[key:gsub("%s+", "")] = value:gsub("%s+", "")
      end
    end
  end
  f:close()
end

return M
