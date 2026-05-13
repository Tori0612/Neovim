-- @p lua/globals/_init.lua
-- This section is for the global configs, such as keymaps, options and the autocompletion logic.
-- Its worth noting that this section is initialized before all others. About then, the settings (options)
-- are nicely organized and you can find pretty much everything that you need to know, and about the keymaps,
-- all have description, so its pretty easy to get, check inside @p lua/globals/completion.lua to see more about it.
local loader = require('utils.loader')

loader.load('globals', {
  'ftypes',
  'options',
  'autocmds',
  'keymaps',
})

require('globals.env').load()

-- require('globals.completion')
-- require('globals.vimtex')
