return {

  -- =========================================================
  -- Mason: installer only
  -- =========================================================
  {
    'williamboman/mason.nvim',
    config = true,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      ensure_installed = {
        'pyright',
        'texlab',
        'lua_ls',
        'ts_ls',
        'tailwindcss',
        'html',
        'cssls',
        'elixirls',
        'jdtls',
        'clangd',
        'eslint'
      },
      automatic_installation = true,
      automatic_enable = false,
      automatic_setup = false,
    },
  },

  {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
  },

  -- =========================================================
  -- LSP Core
  -- =========================================================
  {
    'neovim/nvim-lspconfig',
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local util = require('lspconfig.util')

      local node_path = vim.fn.expand(
        '/home/tori0612/.nvm/versions/node/v22.21.1/bin/node'
      )
      local vba_lsp_path =
      vim.fn.expand('~/tools/VBA-LanguageServer/server/out/server.js')

      -- -----------------------------------------------------
      -- Global diagnostics UI
      -- -----------------------------------------------------
      vim.diagnostic.config({
        virtual_text = { prefix = '●', spacing = 4 },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- -----------------------------------------------------
      -- Global diagnostic keymap
      -- -----------------------------------------------------
      vim.keymap.set('n', '<leader>sd', function()
        vim.diagnostic.open_float(nil, {
          focusable = false,
          border = 'rounded',
          scope = 'line',
          source = 'if_many',
          header = 'Diagnostics',
        })
      end, { desc = 'Show diagnostics (line)' })

      -- -----------------------------------------------------
      -- Buffer-local LSP keymaps (correct way)
      -- -----------------------------------------------------
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          local opts = { buffer = ev.buf }

          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>lf', function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })

      -- -----------------------------------------------------
      -- LSP servers
      -- -----------------------------------------------------

      -- Python
      -- Use basedpyright for maximum strictness
      vim.lsp.config('basedpyright', {
        capabilities = capabilities,
        settings = {
          basedpyright = {
            analysis = {
              -- "strict" is the Go-like mode. It flags EVERYTHING.
              typeCheckingMode = "strict",
              -- Force you to handle None types (Rust/Zig style)
              reportOptionalSubscript = true,
              reportOptionalMemberAccess = true,
              -- Don't guess types, force you to annotate them
              reportUnknownParameterType = true,
              reportUnknownVariableType = true,
              -- Blank space
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
            },
          },
        },
      })
      vim.lsp.enable('basedpyright')

      -- Julia
      local lsp_env = vim.fn.expand("~/.julia/environments/lsp")
      local sysimage_path = lsp_env .. "/sysimage.so"
      vim.lsp.config('julials', {
        cmd_env = {
          JULIA_NUM_THREADS = "1"
        },
        cmd = {
          "julia",
          "--project=" .. lsp_env,
          "--sysimage=" .. sysimage_path,
          "--startup-file=no",
          "--history-file=no",
          "-e", [[
            using Pkg
            using LanguageServer

            # This logic finds the project root
            depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
            project_path = let
                dirname(something(
                    Base.load_path_expand((
                        p = get(ENV, "JULIA_PROJECT", nothing);
                        p === nothing ? nothing : isempty(p) ? nothing : p
                    )),
                    Base.current_project(),
                    get(Base.load_path(), 1, nothing),
                    Base.load_path_expand("@v#.#"),
                ))
            end

            @info "Running turbo language server" VERSION pwd() project_path depot_path
            server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
            server.runlinter = true
            run(server)
        ]]
        },
        settings = {
          julia = {
            symbolCacheDownload = true,
            lint = {
              missingrefs = "all",
              iter = true,
              lazy = true,
              modname = true,
            },
          },
        },
      })
      vim.lsp.enable('julials')

      -- Lua
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim', 'love' } },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
          },
        },
      })
      vim.lsp.enable('lua_ls')

      -- TypeScript / JavaScript
      vim.lsp.config('ts_ls', {
        capabilities = capabilities,
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'javascript.jsx',
        },
        init_options = {
          preferences = {
            includeInlayParameterNameHints = 'none',
            includeInlayFunctionLikeReturnTypeHints = false,
            includeInlayVariableTypeHints = false,
          },
        },
        settings = {
          typescript = { format = { semicolons = 'insert' } },
          javascript = { format = { semicolons = 'insert' } },
        },
      })
      vim.lsp.enable('ts_ls')

      -- ESLint (lint only)
      vim.lsp.config('eslint', {
        capabilities = capabilities,
        root_dir = util.root_pattern(
          '.eslintrc',
          '.eslintrc.js',
          '.eslintrc.json',
          'package.json',
          '.git'
        ),
        on_attach = function(client)
          client.server_capabilities.completionProvider = false
          client.server_capabilities.hoverProvider = false
        end,
      })
      vim.lsp.enable('eslint')

      -- Go (gopls)
      vim.lsp.config('gopls', {
        capabilities = capabilities,
        cmd = { 'gopls' },
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_markers = { 'go.work', 'go.mod', '.git' },
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true, -- Use a stricter formatter
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      })
      vim.lsp.enable('gopls')


      -- Typst LSP
      vim.lsp.config('typst_lsp', {
        capabilities = capabilities,
        cmd = { "/usr/local/bin/typst-lsp" },
        settings = {
          exportPdf = "onSave"  -- Auto-compiles on save
        }
      })
      vim.lsp.enable('typst_lsp')

      -- Typst keymaps (LaTeX-style)
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'typst',
        callback = function(ev)
          local opts = { buffer = ev.buf }

          vim.keymap.set('n', '<leader>tc', function()
            vim.cmd('!typst compile ' .. vim.fn.expand('%'))
          end, vim.tbl_extend('force', opts, { desc = 'Compile Typst' }))

          vim.keymap.set('n', '<leader>tp', function()
            local pdf = vim.fn.expand('%:r') .. '.pdf'
            vim.cmd('!zathura ' .. pdf .. ' &')
          end, vim.tbl_extend('force', opts, { desc = 'View Typst PDF' }))

          vim.keymap.set('n', '<leader>tx', function()
            vim.cmd('!rm -f *.pdf')
          end, vim.tbl_extend('force', opts, { desc = 'Clean PDFs' }))
        end,
      })

      -- Clangd
      vim.lsp.config('clangd', {
        capabilities = capabilities,
        cmd = {
          '/usr/bin/clangd',
          '--background-index',
          '--log=verbose',
          '--clang-tidy',
          '--completion-style=detailed',
          '--header-insertion=iwyu',
          '--pch-storage=memory',
        },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        root_dir = function (fname)
          return vim.fn.getcwd()
        end
      })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'c', 'cpp', 'objc', 'objcpp' },
        callback = function()
          vim.lsp.start(vim.lsp.config.clangd)
        end,
      })

      vim.lsp.config('zls', {
        capabilities = capabilities,
        cmd = { "/usr/local/bin/zls" },
        settings = {
          zig = {
            zigPath = vim.fn.expand("~/.zig/zig-x86_64-linux-0.16.0-dev.2193+fc517bd01"),
          }
        }
      })
      vim.lsp.enable('zls')

      -- HTML
      vim.lsp.config('html', {
        capabilities = capabilities,
        settings = {
          html = {
            format = {
              templating = true,
              wrapLineLength = 120,
              unformatted = 'pre,code,textarea',
            },
            hover = {
              documentation = true,
              references = true,
            }
          },
        },
        init_options = {
          provideFormatter = false,
          embeddedLanguages = {
            css = true,
            javascript = true,
          },
        },
      })
      vim.lsp.enable('html')

      -- CSS
      vim.lsp.config('cssls', {
        capabilities = capabilities,
        settings = {
          css = { validate = true },
          scss = { validate = true },
          less = { validate = true },
        },
      })
      vim.lsp.enable('cssls')

      -- Tailwind
      vim.lsp.config('tailwindcss', {
        capabilities = capabilities,
        filetypes = { 'html', 'css', 'javascriptreact', 'svelte' },
      })
      vim.lsp.enable('tailwindcss')

      -- TeX
      vim.lsp.config('texlab', {
        capabilities = capabilities,
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
      })
      vim.lsp.enable('texlab')

      -- Elixir
      vim.lsp.config('elixirls', {
        capabilities = capabilities,
        settings = {
          elixirLS = {
            dialyzerEnabled = false,
            fetchDeps = false,
          },
        },
      })
      vim.lsp.enable('elixirls')

      -- VBA (manual)
      vim.lsp.config('vba_lsp', {
        capabilities = capabilities,
        cmd = { node_path, vba_lsp_path, '--stdio' },
        filetypes = { 'vba', 'vb', 'vbs', 'bas', 'cls' },
        root_dir = util.root_pattern('.git', 'vba.json'),
      })
      vim.lsp.enable('vba_lsp')
    end,
  },

  -- =========================================================
  -- CMP
  -- =========================================================
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
    },
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        sources = {
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'buffer', priority = 500 },
          { name = 'copilot', priority = 100 },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            local suggestion = require('copilot.suggestion')
            if suggestion.is_visible() then
              suggestion.accept()
            elseif cmp.visible()
            then local entry = cmp.get_selected_entry()
              if not entry then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              end cmp.confirm()
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
      })

      cmp.event:on('menu_opened', function()
        vim.b.copilot_suggestion_hidden = true
      end)

      cmp.event:on('menu_closed', function()
        vim.b.copilot_suggestion_hidden = false
      end)
    end,
  },
}
