local M = {}

function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.n(lhs, rhs, opts)
  M.map("n", lhs, rhs, opts)
end

function M.i(lhs, rhs, opts)
  M.map("i", lhs, rhs, opts)
end

function M.v(lhs, rhs, opts)
  M.map("v", lhs, rhs, opts)
end

function M.t(lhs, rhs, opts)
  M.map("t", lhs, rhs, opts)
end

function M.o(lhs, rhs, opts)
  M.map("o", lhs, rhs, opts)
end

function M.x(lhs, rhs, opts)
  M.map("x", lhs, rhs, opts)
end

function M.nt(lhs, rhs, opts)
  M.map({ "n", "t" }, lhs, rhs, opts)
end

function M.ox(lhs, rhs, opts)
  M.map({ "o", "x" }, lhs, rhs, opts)
end

return M
