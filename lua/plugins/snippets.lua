-- @p lua/plugins/snippets.lua
local gh = require('helpers.github').gh
vim.pack.add({ { src = gh("L3MON4D3/LuaSnip") } })

local config = vim.fn.stdpath("config")
local is_windows = vim.fn.has("win32") == 1
local path = ""
if not is_windows then
  path = config .. "/lua/snippets/"
else
  path = config .. "\\lua\\snippets\\"
end

require("luasnip").setup({ enable_autosnippets = true })
require("luasnip.loaders.from_lua").load({ paths = path })
local ls = require("luasnip")

-- { Expand Snippets {{{
vim.keymap.set({ "i" }, "<C-e>", function () ls.expand() end, { silent = true })
-- }}}

-- { Jumpings {{{
vim.keymap.set({ "i", "s" }, "<Tab>", function ()
  if ls.jumpable(1) then
    return "<Plug>luasnip-jump-next"
  end
  return "<Tab>"
end, { expr = true, silent = true })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function ()
  if ls.jumpable(-1) then
    return "<Plug>luasnip-jump-prev"
  end
  return "<S-Tab>"
end, { expr = true, silent = true })
-- }}}

-- vim: foldmethod=marker
