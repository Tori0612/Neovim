-- @p lua/plugins/copilot.lua
local gh = require('helpers.github').gh

local function start_copilot()
  vim.pack.add({ { src = gh('zbirenbaum/copilot.lua') } })

  require("copilot").setup({
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<C-s>",
        accept_word = "<C-j>",
        accept_line = "<C-k>",
        next = "<C-]>",
        prev = "<C-[>",
        dismiss = "<C-h>",
      },
    },
    panel = {
      enabled = false,
    },
    filetypes = {
      gitcommit = false,
      help = false,
      latex = true,
      python = true,
    },
  })
end

vim.api.nvim_create_user_command("CopilotToggle", function()
  local loaded = package.loaded["copilot"]
  if not loaded then
    start_copilot()
    print("Copilot: Initialized and Enabled")
  else
    local client = require("copilot.client")
    local cmd = require("copilot.command")
    if not (client and cmd) then
      print("Copilot not loaded yet")
      return
    end

    if client.is_disabled() then
      cmd.enable()
      print("Copilot Enabled")
    else
      cmd.disable()
      print("Copilot Disabled")
    end
  end
end, { desc = "Toggle Copilot AI" })

vim.keymap.set('n', '<leader>ct', '<cmd>CopilotToggle<CR>', { desc = "Toggle Copilot "})
