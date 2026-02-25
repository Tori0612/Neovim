-- @p lua/globals/autocmds.lua
local map = vim.keymap.set
local ts_group = vim.api.nvim_create_augroup("TSManualStart", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    map("n", "l", "<CR>", { buffer = true, remap = true, desc = "Go One Directory Below (netrw)" })
    map("n", "h", "-", { buffer = true, remap = true, desc = "Go One Directory Above (netrw)" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = ts_group,
  pattern = { "java", "go", "lua", "c", "zig" },
  callback = function (args)
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if lang then
      vim.treesitter.start(args.buf, lang)
    end
  end
})
