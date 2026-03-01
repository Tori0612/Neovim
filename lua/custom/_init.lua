-- @p lua/custom/_init.lua
-- This section is for what i like calling "native plugins" at the end of the day
-- basically all plugins are native, but the initial plan of this project was to have
-- less plugins as possible, and some of these i personally consider necessary, so i
-- tried doing my own version of them, and the last three ones i thought of doing on the
-- process of configuring stuff.

require('custom.surround')        -- inspiration: @l https://github.com/tpope/vim-surround
require('custom.jumper')          -- inspiration: @l https://github.com/ThePrimeagen/harpoon
require('custom.statusline')      -- inspiration: @l https://github.com/nvim-lualine/lualine.nvim
require('custom.termtools')        -- inspiration: @l https://github.com/akinsho/toggleterm.nvim
require('custom.arvex')
require('custom.theme_switcher')
require('custom.highlights')
require('custom.toc')
