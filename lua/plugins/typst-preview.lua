-- @p lua/plugins/typst-preview.lua
local gh = require('helpers.github').gh
vim.pack.add({ { src = gh('chomosuke/typst-preview.nvim') } })

require('typst-preview').setup({})
local map = vim.keymap.set
map("n", "<leader>tt", ":TypstPreviewToggle<CR>", { desc = "Toggles The Typst Preview" })
