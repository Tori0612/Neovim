return {
  "scalameta/nvim-metals",
  ft = { "scala", "sbt", "sbtsc" }, -- Carrega apenas para arquivos Scala

  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp", -- ❗️ Dependência crucial
  },

  config = function()
    -- A função 'config' do lazy.nvim chama o 'setup' do metals)
    local metals = require("metals")

    local metals_config = metals.bare_config()

    metals_config.capabilities = vim.g.cmp_lsp_capabilities or vim.lsp.protocol.make_client_capabilities()

    metals_config.settings = {
            showImplicitArguments = true,
            showInferredType = true,
        }
    metals_config.init_options.statusBarProvider = "on"

     -- Autocmd so Metals initializes only for Scala files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "scala", "sbt" },
      callback = function()
        metals.initialize_or_attach(metals_config)
      end,
    })


    -- KEYMAPS ÚTEIS para buffers Scala
    local map = vim.keymap.set
    local nmap = function(keys, func, desc)
      if desc then
        desc = "[Metals] " .. desc
      end
      map("n", keys, func, { buffer = true, desc = desc })
    end

    -- Comandos de instalação/build
    nmap("<leader>mi", "<cmd>MetalsInstall<cr>", "Instalar/Atualizar Metals")
    nmap("<leader>mR", "<cmd>MetalsRestart<cr>", "Reiniciar o Metals")
    nmap("<leader>mI", "<cmd>MetalsImportBuild<cr>", "Importar build (sbt)")

    -- Navegação e Informação
    nmap("gd", "<cmd>MetalsGotoDefinition<cr>", "Ir para Definição")
    nmap("gr", "<cmd>MetalsFindReferences<cr>", "Encontrar Referências")
    nmap("<leader>mt", "<cmd>MetalsTypeHierarchy<cr>", "Hierarquia de Tipos")

    -- Diagnósticos e Ações
    nmap("<leader>ma", "<cmd>MetalsCodeAction<cr>", "Ação de Código")
    nmap("<leader>md", "<cmd>MetalsToggleLogs<cr>", "Alternar Logs")
  end,
}
