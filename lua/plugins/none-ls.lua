return {

    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            local formatting = null_ls.builtins.formatting
            local diagnostics = null_ls.builtins.diagnostics

            null_ls.setup({
                sources = {
                    -- Formatting
                    formatting.isort,
                },
                diagnostic_config = {
                    virtual_text = { prefix = "●", spacing = 3 },
                    signs = true,
                    underline = true,
                },
                --[[
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        local aug = vim.api.nvim_create_augroup("LspFormatting", {})
                        vim.api.nvim_clear_autocmds({ group = aug, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = aug,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
                ]]--
            })
        end,
    }
}
