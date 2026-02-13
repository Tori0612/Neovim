-- @p lua/plugins/oil.lua
local gh = require('helpers.github').gh
vim.pack.add({ { src = gh('stevearc/oil.nvim') } })

require("oil").setup({
  default_file_explorer = false,
  view_options = {
    show_hidden = true,
  },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
