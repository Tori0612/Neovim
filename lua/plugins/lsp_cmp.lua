return {
    -- Mason: LSP installer
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end,
    },
    -- Mason-LSP bridge
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
        opts = {
            ensure_installed = { 'pyright', 'texlab', 'lua_ls', 'ts_ls', 'tailwindcss', 'html', 'cssls', 'elixirls', },
            automatic_enable = true,
        },
        config = function(_, opts)
            require('mason-lspconfig').setup(opts)
            vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { desc = 'LSP Go to definition' })
            vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, { desc = 'LSP References' })
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP Code action' })
        end,
    },
    -- LSP Config 
    {
        'neovim/nvim-lspconfig',
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local util = require("lspconfig.util")

            local node_path = vim.fn.expand('/home/tori0612/.nvm/versions/node/v22.21.1/bin/node')
            local vba_lsp_path = vim.fn.expand('~/tools/VBA-LanguageServer/server/out/server.js')

            local servers = {
                pyright = {
                    settings = {
                        python = {
                            analysis = {
                                typeCheckingMode = 'basic',
                                autoSearchPaths = true,
                                useLibraryCodeForTypes = true,
                                diagnosticMode = 'openFilesOnly',
                            },
                        },
                    },
                },
                ts_ls = {
                    settings = {
                        typescript = { format = { semicolons = 'insert' } },
                        javascript = { format = { semicolons = 'insert' } },
                    },
                },
                html = {
                    settings = {
                        html = { format = { wrapLineLength = 120, unformatted = 'pre,code,textarea' } },
                    },
                },
                cssls = {
                    settings = {
                        css = { validate = true },
                        scss = { validate = true },
                        less = { validate = true },
                    },
                },
                tailwindcss = {
                    capabilities = capabilities,
                    filetypes = { 'html', 'css', 'javascriptreact', 'svelte' },
                },
                texlab = {
                    settings = {
                        texlab = {
                            build = {
                                executable = 'latexmk',
                                args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
                                onSave = true,
                            },
                            diagnostics = {
                                ignoredPatterns = { '^Overfull', '^Underfull' },
                            },
                        },
                    },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = { globals = { 'vim' } },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false,
                            },
                        },
                    },
                },
                vba_lsp = {
                    cmd = { node_path, vba_lsp_path, "--stdio" },
                    filetypes = { 'vba, vb', 'vbs', 'bas', 'cls' },
                    root_dir = util.root_pattern(".git", "vba.json"),
                    settings = {}
                },
                elixirls = {
                    settings = {
                        elixirLS = {
                            dialyzerEnabled = false,
                            fetchDeps = false
                        }
                    }
                },
            }

            for server_name, config in pairs(servers) do
                config.capabilities = capabilities
                vim.lsp.config(server_name, config)
            end

            vim.lsp.enable('vba_lsp')

            vim.diagnostic.config({
                virtual_text = { prefix = '●', spacing = 4 },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })
            -- Show full diagnostic for the current line in a floating window
            vim.keymap.set('n', '<leader>sd', function()
                vim.diagnostic.open_float(nil, {
                    focusable = false,
                    border = 'rounded',
                    scope = 'line',
                    source = 'if_many',
                    header = 'Diagnostics',
                    prefix = '',
                })
            end, { desc = 'Show diagnostics for current line' })


            -- Keymaps
            vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { desc = 'LSP Go to definition' })
            vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, { desc = 'LSP References' })
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP Code action' })
        end,
    },

    -- CMP: Autocompletion
    {
        'hrsh7th/nvim-cmp',
        dependencies = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer' },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                sources = cmp.config.sources({
                    { name = 'nvim_lsp', group_index = 2  }, -- LSP completions (pyright)
                    { name = 'buffer', group_index = 2  },-- Buffer words
                    { name = 'copilot', group_index = 2  }, -- AI completions (copilot)
                }),
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.locality,
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        local suggestion = require('copilot.suggestion')
                        if suggestion.is_visible() then
                            suggestion.accept()
                        elseif cmp.visible() then
                            local entry = cmp.get_selected_entry()
                            if not entry then
                                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                            end
                            cmp.confirm()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
            })
            cmp.event:on("menu_opened", function ()
                vim.b.copilot_suggestion_hidden = true
            end)
            cmp.event:on("menu_closed", function ()
                vim.b.copilot_suggestion_hidden = false
            end)
        end,
    },
}
