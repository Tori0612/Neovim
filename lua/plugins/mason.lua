-- @p lua/plugins/mason.lua
local gh = require('utils.github').gh
vim.pack.add({
  { src = gh("mason-org/mason.nvim") },
  { src = gh("WhoIsSethDaniel/mason-tool-installer.nvim") }
})

require "mason".setup()

require "mason-tool-installer".setup({
  ensure_installed = {
    "lua-language-server",
  },
  auto_update = false,
  run_on_start = true,
})
