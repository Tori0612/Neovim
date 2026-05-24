-- @p lua/plugins/typst-preview.lua
local gh = require('utils.github').gh
vim.pack.add({ { src = gh('chomosuke/typst-preview.nvim') } })

require('typst-preview').setup({})
vim.keymap.set("n", "<leader>tp", ":TypstPreviewToggle<CR>", { desc = "Toggles The Typst Preview" })
