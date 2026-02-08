return {
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
      vim.keymap.set('v', '<leader>fw', [["zy:lua require('telescope.builtin').grep_string({ search = vim.fn.getreg('z') })<CR>]], { desc = "Find visual selection in project" })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope find diagnostics' })
      require('telescope').setup({
        defaults = {
          file_ignore_patterns = { "node_modules", "^.git/", "dist/", 'vendor/', "%.lock" },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
          live_grep = {
            additional_args = function(opts)
              return { "--hidden" }
            end,
          },
        },
      })
    end
  }
}
