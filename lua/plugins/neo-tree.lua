return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',  -- Stable branch
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',  -- For file icons
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Toggle NeoTree' },
    },
    config = function()
      require('neo-tree').setup({
        close_if_last_window = true,  -- Close if it's the last window
        popup_border_style = 'rounded',
        enable_git_status = true,
        enable_diagnostics = true,
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,  -- Show hidden files
            hide_gitignored = true,
          },
        },
        window = {
          position = 'left',  -- Sidebar on left
          width = 30,
        },
      })
    end,
  },
}
