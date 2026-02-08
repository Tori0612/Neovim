return {
  'echasnovski/mini.align',
  version = false,
  config = function()
    require('mini.align').setup({
      -- Default mappings
      mappings = {
        start = 'ga',
        start_with_preview = 'gA',
      },
    })
  end,
}
