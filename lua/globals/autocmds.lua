-- @p lua/globals/autocmds.lua
local map = require('utils.map')

vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    map.n("l", "<CR>", { buffer = true, remap = true, desc = "Go One Directory Below (netrw)" })
    map.n("h", "-", { buffer = true, remap = true, desc = "Go One Directory Above (netrw)" })
  end,
})

