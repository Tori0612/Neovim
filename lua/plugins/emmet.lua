-- @p lua/plugins/emmet.lua
local gh = require("utils.github").gh
vim.pack.add({ { src = gh("mattn/emmet-vim") } })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "css", "javascriptreact", "typescriptreact" },
  callback = function ()
    vim.g.user_emmet_leader_key = ','
  end,
  once = true,
})
