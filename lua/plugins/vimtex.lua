return {
    {
        'lervag/vimtex',
        ft = 'tex', -- Load only for .tex files
        config = function()
            vim.g.vimtex_view_method = 'zathura' -- Use external viewer

            vim.g.vimtex_compiler_method = 'latexmk'
            vim.g.vimtex_callback_progpath = 'nvim'
            vim.g.vimtex_compiler_latexmk = {
                options = {
                    '-pdf',
                    '-interaction=nonstopmode',
                    '-synctex=1',
                },
            }

            vim.g.vimtex_quickfix_mode = 0 -- Disable quickfix window
            -- Keymaps for LaTeX
            vim.keymap.set('n', '<leader>ll', '<cmd>VimtexCompile<cr>', { desc = 'Compile LaTeX' })
            vim.keymap.set('n', '<leader>lv', '<cmd>VimtexView<cr>', { desc = 'View LaTeX PDF' })
            vim.keymap.set('n', '<leader>lc', '<cmd>VimtexClean<cr>', { desc = 'Clean LaTeX aux files' })
        end,
    },
}
