-- @p lua/plugins/undotree.lua
local gh = require("helpers.github").gh

vim.pack.add({ { src = gh('mbbill/undotree') } })

local function toggle_and_focus()
  vim.cmd.UndotreeToggle()

  local winid = vim.fn.bufwinid("undotree")
  if  winid ~= 1 then
    vim.api.nvim_set_current_win(winid)
  end
end

vim.keymap.set("n", "<leader>u", toggle_and_focus, { desc = "Toggle and Focus UndoTree"} )
