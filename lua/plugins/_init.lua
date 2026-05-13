-- @p lua/plugins/_init.lua
local loader = require('utils.loader')

loader.load('plugins', {
  'jdtls', 'snippets', 'mini', 'oil', 'mason',
  'cmp', 'copilot', 'conjure', 'emmet', 'typst-preview',
  'vimtex', 'undotree'
})
