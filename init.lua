-- @p init.lua
local config_path = vim.fn.stdpath("config")
vim.opt.runtimepath:prepend(config_path)

vim.loader.enable()
require('globals._init')
require('custom._init')
require('colors._init')
require('plugins._init')
require('lsp._init')
