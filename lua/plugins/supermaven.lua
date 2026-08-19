-- @p lua/plugins/supermaven.lua
local gh = require('utils.github').gh

local supermaven_is_on = false

local function start_supermaven()
  vim.pack.add({ { src = gh("supermaven-inc/supermaven-nvim") } })
  require('supermaven-nvim').setup({
    keymaps = {
      clear_suggestion = '<C-h>',
      accept_word = '<C-j>',
    },
    ignore_filetypes = {
      gitcommit = true,
      help = true,
    },
  })
  supermaven_is_on = true
end

vim.api.nvim_create_user_command("SupermavenToggle", function()
  local loaded = package.loaded["supermaven-nvim"]

  if not loaded then
    start_supermaven()
    vim.notify("Supermaven: Initialized and Enabled", vim.log.levels.INFO)
    return
  end

  local api = require("supermaven-nvim.api")
  local preview = require("supermaven-nvim.completion_preview")

  if supermaven_is_on then
    api.stop()
    if preview.has_suggestion() then
      preview.on_clear_suggestion()
    end
    supermaven_is_on = false
    vim.notify("Supermaven Disabled", vim.log.levels.WARN)
  else
    api.start()
    supermaven_is_on = true
    vim.notify("Supermaven Enabled", vim.log.levels.INFO)
  end
end, { desc = "Toggle Supermaven" })

vim.keymap.set('n', '<leader>ct', '<cmd>SupermavenToggle<CR>', { desc = "Toggle Supermaven" })
