return {
  'chomosuke/typst-preview.nvim',
  ft = 'typst',
  version = '0.3.*',
  build = function()
    require('typst-preview').update()
  end,
  config = function()
    require('typst-preview').setup({
      open_cmd = 'firefox %s',  -- or your browser
    })
    -- Same keymaps, but opens live preview
    vim.keymap.set('n', '<leader>ll', '<cmd>TypstPreview<cr>',
      { desc = 'Start Typst live preview' })
  end,
}
