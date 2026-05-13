-- @p lua/plugins/vimtex.lua
local gh = require('utils.github').gh
vim.pack.add({ { src = gh("lervag/vimtex") } })
