return {
  {
    'jiaoshijie/undotree',
    dependencies = { 'nvim-lua/plenary.nvim' },  -- Required for async operations
    keys = {
      { '<leader>u', "<cmd>lua require('undotree').toggle()<cr>", desc = 'Toggle Undotree' },
    },
    config = function()
      require('undotree').setup({
        position = 'left',         -- Window position (left/right)
        -- Optional: More settings
        -- diff = { inline = true }, -- Inline diff preview
        -- keymaps = { ... },       -- Customize if needed
      })
    end,
  },
}
