-- @p init.lua
vim.loader.enable()
require('helpers.env').load()
require('globals._init')
require('custom._init')
require('colors._init')
require('plugins._init')
require("lsp._init")
