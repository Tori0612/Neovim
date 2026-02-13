-- @p lua/helpers/github.lua
-- This helper is just a dumb one that i saw on neovim's documentation, and i found it
-- pretty nice at the begining of the configuration for this refactor, but yeah, nothing much about it.

local M = {}

M.gh = function(x)
	return "https://github.com/" .. x
end

return M
