-- @p lua/custom/arvex.lua
local is_windows = vim.fn.has("win32") == 1
local parser_path = ""
local languages = { "java", "lua", "go", "c", "zig", "typst" }

if is_windows then
  parser_path = vim.fn.stdpath("config") .. "\\parser\\"
else
  parser_path = vim.fn.stdpath("config") .. "/parser/"
end

for _, lang in ipairs(languages) do
  vim.treesitter.language.add(lang, {
    path = parser_path .. lang .. ".so"
  })
end

local ts_group = vim.api.nvim_create_augroup("TSManualStart", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = ts_group,
  pattern = languages,
  callback = function (args)
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if lang then
      vim.treesitter.start(args.buf, lang)
    end
  end
})
