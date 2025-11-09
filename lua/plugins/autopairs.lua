return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter', -- Load when entering insert mode
    config = function()
      require('nvim-autopairs').setup({
        -- Optional: Customize settings
        check_ts = true, -- Enable treesitter integration
        disable_filetype = { 'TelescopePrompt', 'vim' }, -- Disable in Telescope
      })
    end,
  },
}
