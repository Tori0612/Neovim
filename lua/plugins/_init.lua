-- @p lua/plugins/_init.lua
local loader = require('utils.loader')

loader.load('plugins', {
  'luasnip',
  'mini',
  'oil',
  'mason',
  'blink',
  -- 'typst-preview', 'vimtex',
  'undotree',
  'smear_cursor',
  'markview', 'fastspell',
  -- 'copilot',
  -- 'supermaven',
  -- 'jdtls', emmet
})
