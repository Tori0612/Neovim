-- @p lua/colors/colorscheme.lua
local gh = require('utils.github').gh

vim.pack.add({
  { src = gh("rebelot/kanagawa.nvim") }
})
require('kanagawa').setup({
  compile = false,
  undercurl = true,
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = true,
  dimInactive = false,
  terminalColors = true,
  colors = {
    palette = {},
    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  },
  theme = "wave",
  background = {
    dark = "wave",
    light = "lotus"
  },
})
vim.cmd("colorscheme kanagawa-wave")
