return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                -- Size settings (ignored for floating terminals)
                size = 20,

                -- Hide line numbers, etc. for a cleaner look
                hide_numbers = true,
                shade_terminals = true,
                shading_factor = 2, -- darker background
                start_in_insert = true,
                insert_mappings = true,
                persist_size = true,

                -- Default orientation
                direction = "float",

                -- Floating window styling
                float_opts = {
                    border = "curved", -- options: 'single', 'double', 'shadow', 'curved'
                    width = math.floor(vim.o.columns * 0.9),
                    height = math.floor(vim.o.lines * 0.8),
                    winblend = 10, -- transparency (0 = solid, 100 = fully transparent)
                    highlights = {
                        border = "Normal",
                        background = "Normal",
                    },
                },

                -- Optional shell (you can set to bash, zsh, or powershell)
                shell = vim.o.shell,
            })

            -- Optional keymaps to manage multiple terminals
            local Terminal = require("toggleterm.terminal").Terminal

            local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
            function _LAZYGIT_TOGGLE()
                lazygit:toggle()
            end

            vim.keymap.set("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true, desc = "Toggle Lazygit terminal" })

            -- Optional: map Ctrl+\\ globally too
            vim.keymap.set({ "n", "t" }, "<C-\\>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
            vim.keymap.set({ "n", "t" }, "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
        end,
    },
}

