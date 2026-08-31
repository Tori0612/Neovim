-- @p lua/plugins/_99.lua
local gh = require('utils.github').gh
local map = require('utils.map')

vim.pack.add({ { src = gh("ThePrimeagen/99") } })

local _99 = require("99")

local cwd = vim.uv.cwd()
local basename = vim.fs.basename(cwd)

_99.setup({
  logger = {
    level = _99.DEBUG,
    path = "/" .. basename .. ".99.debug",
    print_on_error = true,
  }
})

map.v("<leader>9v", function()
  _99.visual()
end)

map.n("<leader>9x", function()
  _99.stop_all_requests()
end)

vim.keymap.set("n", "<leader>9s", function()
  _99.search()
end)
