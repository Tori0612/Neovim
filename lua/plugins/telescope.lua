return {
  -- The plugin name must be the value of a key-value pair.
  {
    'nvim-telescope/telescope.nvim',
    
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
      local builtin = require('telescope.builtin')

      -- Keymaps
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope git files' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Telescope find word' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope find diagnostics' })
      require('telescope').setup({})
    end
  } -- The entire configuration must be wrapped in its own table.
}
