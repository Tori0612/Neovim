-- @p lua/plugins/smear_cursor.lua
local gh = require("utils.github").gh

vim.pack.add({ { src = gh("sphamba/smear-cursor.nvim") } })

require("smear_cursor").setup({
  stiffness = 0.5,
  trailing_stiffness = 0.8,
  distance_stop_animating = 0.6,
  damping = 0.92,
  time_interval = 10,
  smear_insert_mode = false,
})
