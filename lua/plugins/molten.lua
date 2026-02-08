return {
    {
        "benlubas/molten-nvim",
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            -- these are examples, not defaults. Please see the readme
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 30
            vim.g.molten_auto_open_output = false -- prevent pop-ups if you don't want them immediately
            vim.g.molten_wrap_output = true
            vim.g.molten_virt_text_output = true
            vim.g.molten_virt_lines_off_by_1 = false
            -- vim.g.molten_image_location = "float"
        end,
        keys = {
            -- "No Cell" Workflow Keymaps
            { "<C-i><C-u>", ":MoltenInit<CR>", desc = "Start Molten", silent = true },
            { "<leader>me", ":MoltenEvaluateOperator<CR>", desc = "Run operator selection", silent = true },
            { "<leader>mj", ":MoltenInit julia-1.12<CR>", desc = "Start Molten With Julia", silent = true },
            { "<leader>ml", ":MoltenEvaluateLine<CR>", desc = "Run current line", silent = true },
            { "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>", mode = "v", desc = "Run visual selection", silent = true },
            { "<leader>mb", ":MoltenOpenInBrowser<CR>", desc = "Open output in browser", silent = true },
            { "<leader>md", ":MoltenDelete<CR>", desc = "Delete cell output", silent = true },
            { "<leader>ms", ":MoltenShowOutput<CR>", desc = "Show output window", silent = true },
        },
    },

    {
        "3rd/image.nvim",
        build = false,
        opts = {
            backend = "kitty",
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "markdown", "vimwiki", "quarto" },
                },
            },
            max_width = nil,
            max_height = nil,
            max_width_window_percentage = math.huge,
            max_height_window_percentage = 70,
            window_overlap_clear_enabled = true, -- toggles images when windows overlap
        },
    },
}
