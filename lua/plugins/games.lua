return {
    {
        'ThePrimeagen/vim-be-good',
        lazy = false,
        keys = {
            { "<leader>vg", '<cmd>VimBeGood<cr>', desc = 'Open Vim-Be-Good' },
        },
        config = function()
      vim.g.vimtex_view_sumatrapdf_check_for_update = 1  -- Auto-check for PDF updates      vim.g.vim_be_good_difficulty = 'noob' 
            vim.g.vim_be_good_delete_me_offset = 1
        end,
    },
}
