return {
    {
        "mattn/emmet-vim",
        ft = { "html", "css", "javascriptreact", "typescriptreact", "markdown", "htmldjango" },
        init = function()
            vim.g.user_emmet_mode = 'a'          -- enable all modes
            vim.g.user_emmet_leader_key = ','    -- use ',' as trigger prefix
        end,
    },

    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        config = function()
            require('nvim-ts-autotag').setup({
                opts = {
                    enable_close = true,       -- auto close tags
                    enable_rename = true,      -- auto rename pairs
                    enable_close_on_slash = true -- </ triggers autoclose
                },
            })
        end,
    }
}

