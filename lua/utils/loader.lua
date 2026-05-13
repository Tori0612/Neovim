local M = {}

function M.load(namespace, modules)
  for _, name in ipairs(modules) do
    require(namespace .. "." .. name)
  end
end

function M.load_safe(namespace, modules)
  for _, name in ipairs(modules) do
    pcall(require, namespace .. "." .. name)
  end
end

return M
