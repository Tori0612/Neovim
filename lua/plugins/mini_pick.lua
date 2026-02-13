-- @p lua/plugins/mini_pick.lua
local gh = require('helpers.github').gh
vim.pack.add({ { src = gh('echasnovski/mini.pick') } })

require('mini.pick').setup()

-- { Find Files
vim.keymap.set('n', '<leader>ff', function()
  require('mini.pick').builtin.files()
end, { desc = 'Find files' })
-- }

-- { Live Grep
vim.keymap.set('n', '<leader>fg', function()
  require('mini.pick').builtin.grep_live()
end, { desc = 'Live grep' })
-- }

-- { Find Buffers
vim.keymap.set('n', '<leader>fb', function()
  require('mini.pick').builtin.buffers() -- pretty nice if using heavy lsps like jdtls
end, { desc = 'Find buffers' })
-- }

-- { Find Diagnostics (buffer or workspace wise)
vim.keymap.set('n', '<leader>fd', function()
  local buftype = vim.bo.buftype
  local scope = (buftype == '') and 'current' or 'all'
  require('mini.pick').builtin.diagnostic({ scope = scope })
end, { desc = 'Find diagnostics (smart)' })
-- }

-- { Find Help
vim.keymap.set("n", "<leader>fh", function()
  require('mini.pick').builtin.help()
end, { desc = 'Find help' })
-- }
