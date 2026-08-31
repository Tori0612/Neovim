-- @p lua/colors/colorscheme.lua
local gh = require('utils.github').gh

vim.pack.add({
  { src = gh("rose-pine/neovim") }
})

require("rose-pine").setup({
  variant = "moon",
  dark_variant = "moon",
  dim_inactive_windows = false,
  extend_background_behind_borders = true,

  enable = {
    terminal = true,
    legacy_highlights = true,
    migrations = true,
  },

  styles = {
    bold = true,
    italic = true,
    transparency = true,
  },
})
vim.cmd("colorscheme rose-pine")
