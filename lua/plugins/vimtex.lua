-- @p lua/plugins/vimtex.lua
local gh = require('helpers.github').gh
vim.pack.add({ { src = gh("lervag/vimtex") } })
