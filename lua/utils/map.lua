-- @p lua/utils/map.lua
local M = {}

---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param opts? vim.keymap.set.Opts
function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- @t [Normal Mode] 
---@param lhs string
---@param rhs string|function
---@param opts? vim.keymap.set.Opts
function M.n(lhs, rhs, opts)
  M.map("n", lhs, rhs, opts)
end

-- @t [Insert Mode] 
---@param lhs string
---@param rhs string|function
---@param opts? vim.keymap.set.Opts
function M.i(lhs, rhs, opts)
  M.map("i", lhs, rhs, opts)
end

-- @t [Visual Mode] 
---@param lhs string
---@param rhs string|function
---@param opts? vim.keymap.set.Opts
function M.v(lhs, rhs, opts)
  M.map("v", lhs, rhs, opts)
end

-- @t [Terminal Mode] 
---@param lhs string
---@param rhs string|function
---@param opts? vim.keymap.set.Opts
function M.t(lhs, rhs, opts)
  M.map("t", lhs, rhs, opts)
end

-- @t [Operator Pending Mode] 
---@param lhs string
---@param rhs string|function
---@param opts? vim.keymap.set.Opts
function M.o(lhs, rhs, opts)
  M.map("o", lhs, rhs, opts)
end

-- @t [Exclusive Visual Mode] 
---@param lhs string
---@param rhs string|function
---@param opts? vim.keymap.set.Opts
function M.x(lhs, rhs, opts)
  M.map("x", lhs, rhs, opts)
end

-- @t [Normal or Terminal Mode] 
---@param lhs string
---@param rhs string|function
---@param opts? vim.keymap.set.Opts
function M.nt(lhs, rhs, opts)
  M.map({ "n", "t" }, lhs, rhs, opts)
end

-- @t [Pending or Exclusive Mode] 
---@param lhs string
---@param rhs string|function
---@param opts? vim.keymap.set.Opts
function M.ox(lhs, rhs, opts)
  M.map({ "o", "x" }, lhs, rhs, opts)
end

return M
