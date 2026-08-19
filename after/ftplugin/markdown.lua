-- @p after/ftplugin/markdown.lua

vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = "nc"

_G.SurroundPairs = _G.SurroundPairs or {}

_G.SurroundPairs["b"] = { "**", "**" }
_G.SurroundPairs["i"] = { "_", "_" }
_G.SurroundPairs["n"] = { "**_", "_**" }
_G.SurroundPairs["l"] = { "$", "$" }
_G.SurroundPairs["c"] = { "`", "`" }

vim.opt_local.wrap = true
vim.opt_local.linebreak = true

vim.keymap.set('n', 'j', 'gj', { buffer = true })
vim.keymap.set('n', 'k', 'gk', { buffer = true })
