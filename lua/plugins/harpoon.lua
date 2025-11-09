return {
  {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local mark = require('harpoon.mark')
      local ui = require('harpoon.ui')
      vim.keymap.set('n', '<leader>a', mark.add_file, { desc = 'Harpoon add file' })
      vim.keymap.set('n', '<C-h>', ui.toggle_quick_menu, { desc = 'Harpoon toggle menu' })
      vim.keymap.set('n', '<C-z>', function() ui.nav_file(1) end, { desc = 'Harpoon navigate to file 1' })
      vim.keymap.set('n', '<C-s>', function() ui.nav_file(2) end, { desc = 'Harpoon navigate to file 2' })
      vim.keymap.set('n', '<C-e>', function() ui.nav_file(3) end, { desc = 'Harpoon navigate to file 3' })
    end,
  },
}
