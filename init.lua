-- @p init.lua
local config_path = vim.fn.stdpath("config")
vim.opt.runtimepath:prepend(config_path)

vim.filetype.add({
  extension = {
    env = "env",
    hlyrics = "holyrics",
    hll = "xml",
  },
  filename = {
    [".env"] = "env",
  },
  pattern = {
    ["%.env%.[%w_.-]+"] = "env",
  },
})

vim.loader.enable()
require('helpers.env').load()
require('globals._init')
require('custom._init')
require('colors._init')
require('plugins._init')
require('lsp._init')
