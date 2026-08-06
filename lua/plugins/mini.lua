-- @p lua/plugins/mini.lua
local gh = require('utils.github').gh
local map = require('utils.map')

vim.pack.add({
  gh('nvim-mini/mini.nvim'),
  gh('nvim-mini/mini.pick'),
  gh('nvim-mini/mini.extra'),
  gh('nvim-mini/mini.icons'),
  gh('nvim-mini/mini.pairs'),
})

local MiniPick = require('mini.pick')
local MiniExtra = require('mini.extra')
local MiniPairs = require('mini.pairs')
local MiniIcons = require('mini.icons')

MiniPick.setup()
MiniExtra.setup()
-- MiniPairs.setup()
MiniIcons.setup()

-- { Mini Pick {{{
map.n('<leader>ff', function() -- @t [Find Files]
  MiniPick.builtin.files()
end, { desc = 'Find files' })

map.n('<leader>fg', function() -- @t [Live Grep]
  MiniPick.builtin.grep_live()
end, { desc = 'Live grep' })

map.n('<leader>fb', function() -- @t [Find Buffers]
  MiniPick.builtin.buffers() -- pretty nice if using heavy lsps like jdtls
end, { desc = 'Find buffers' })

map.n("<leader>fh", function() -- @t [Find Help]
  MiniPick.builtin.help()
end, { desc = 'Find help' })
-- }}}


-- { Mini Extra {{{
map.n("<leader>fd", function() -- @t [Find Diagnostics] (buffer or workspace wise)
  MiniExtra.pickers.diagnostic()
end)

map.n("<leader>gd", function() -- @t [Find Definitions]
  MiniExtra.pickers.lsp({ scope = "definition" })
end)

map.n("<leader>gr", function() -- @t [Find References]
  MiniExtra.pickers.lsp({ scope = "references" })
end)
-- }}}
