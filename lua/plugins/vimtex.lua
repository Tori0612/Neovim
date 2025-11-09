return {
  {
    'lervag/vimtex',
    ft = 'tex', -- Load only for .tex files
    config = function()
      vim.g.vimtex_view_method = 'general' -- Use external viewer
      vim.g.vimtex_view_general_viewer = 'SumatraPDF' -- Or full path: 'C:\\Program Files\\SumatraPDF\\SumatraPDF.exe'
      vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf' -- Forward search
      vim.g.vimtex_view_general_options_latexmk = '-reuse-instance' -- Reuse instance for continuous compilation
      vim.g.vimtex_compiler_method = 'latexmk'
      vim.g.vimtex_quickfix_mode = 0 -- Disable quickfix window
      vim.g.vimtex_compiler_latexmk = {
        options = {
          '-pdf',
          '-interaction=nonstopmode',
          '-synctex=1',
        },
      }
      -- Keymaps for LaTeX
      vim.keymap.set('n', '<leader>ll', '<cmd>VimtexCompile<cr>', { desc = 'Compile LaTeX' })
      vim.keymap.set('n', '<leader>lv', '<cmd>VimtexView<cr>', { desc = 'View LaTeX PDF' })
      vim.keymap.set('n', '<leader>lc', '<cmd>VimtexClean<cr>', { desc = 'Clean LaTeX aux files' })
    end,
  },
}
