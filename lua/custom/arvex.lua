-- @p lua/custom/arvex.lua
local is_windows = vim.fn.has("win32") == 1
local parser_path = ""

if is_windows then
  parser_path = vim.fn.stdpath("config") .. "\\parser\\"
else
  parser_path = vim.fn.stdpath("config") .. "/parser/"
end

local languages = { "java", "go", "c", "zig" }

for _, lang in ipairs(languages) do
  vim.treesitter.language.add(lang, {
    path = parser_path .. lang .. ".so"
  })
end
