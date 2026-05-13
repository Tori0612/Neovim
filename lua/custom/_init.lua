-- @p lua/custom/_init.lua
-- This section is for what i like calling "native plugins" at the end of the day
-- basically all plugins are native, but the initial plan of this project was to have
-- less plugins as possible, and some of these i personally consider necessary, so i
-- tried doing my own version of them, and the last three ones i thought of doing on the
-- process of configuring stuff.

local loader = require('utils.loader')

loader.load('custom', {
  'surround',           -- inspiration: @l https://github.com/tpope/vim-surround
  'jumper',             -- inspiration: @l https://github.com/ThePrimeagen/harpoon
  'statusline',         -- inspiration: @l https://github.com/nvim-lualine/lualine.nvim
  'termtools',          -- inspiration: @l https://github.com/akinsho/toggleterm.nvim
  'arvex', 'theme_switcher', 'highlights', 'toc',
  -- 'treesitter_manager'
})

-- require('custom.secret_env').setup()
-- require('custom.treesitter_manager')
