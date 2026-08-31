-- @p lua/plugins/supermaven.lua
local gh = require('utils.github').gh

local initialized = false

local function ensure_supermaven()
  if initialized then
    return require("supermaven-nvim.api")
  end

  vim.pack.add({ { src = gh("supermaven-inc/supermaven-nvim") } })

  require('supermaven-nvim').setup({
    keymaps = {
      accept_suggestion = '<C-y>',
      clear_suggestion = '<C-h>',
      accept_word = '<C-j>',
    },
    ignore_filetypes = {
      gitcommit = true,
      help = true,
    },
  })

  initialized = true

  local api = require("supermaven-nvim.api")
  api.stop()

  return api
end


vim.api.nvim_create_user_command("SupermavenTog", function()
  local api = ensure_supermaven()

  api.toggle()

  if api.is_running() then
    vim.notify("Supermaven: Enabled", vim.log.levels.INFO)
  else
    vim.notify("Supermaven: Disabled", vim.log.levels.WARN)
  end
end, {})

vim.keymap.set('n', '<leader>ct', '<cmd>SupermavenTog<CR>', { desc = "Toggle Supermaven" })
