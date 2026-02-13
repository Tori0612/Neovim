-- @p after/ftplugin/java.lua
local jdtls = require('jdtls')
local capabilities = require("helpers.capabilities").get_capabilities()

local root_markers = {'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}
local root_dir = require('jdtls.setup').find_root(root_markers)

if root_dir == "" then return end

local default_jdtls = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
local raw_path = vim.env.JDTLS_PATH or default_jdtls
local jdtls_path = vim.fn.expand(raw_path)

local launcher = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')

local system = 'linux'
local config_path = jdtls_path .. '/config_' .. system

local project_name = vim.fn.fnamemodify(root_dir, ':t')
local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspace/' .. project_name

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', launcher,
    '-configuration', config_path,
    '-data', workspace_dir,
  },

  root_dir = root_dir,
  capabilities = capabilities,
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = false,
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
      },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
  },

  flags = {
    allow_incremental_sync = true,
  },

  -- Keymaps (Java-specific actions)
  on_attach = function(client, bufnr)
    local function java_action(kind)
      vim.lsp.buf.code_action({
        context = {
          only = { kind },
          diagnostics = {},
        }
      })
    end
    -- Generate Getters and Setters (<leader>jg)
    vim.keymap.set('n', '<leader>jg', function() java_action("source.generate.accessors") end,
    { buffer = bufnr, desc = 'Generate Getters/Setters' })

    -- Generate Constructor (<leader>jco)
    vim.keymap.set('n', '<leader>jco', function() java_action("source.generate.constructors") end,
    { buffer = bufnr, desc = 'Generate Constructor' })

    -- Generate toString() (<leader>jts)
    vim.keymap.set('n', '<leader>jts', function() java_action("source.generate.toString") end,
    { buffer = bufnr, desc = 'Generate toString' })

    -- Generate hashCode() and equals() (<leader>jeq)
    vim.keymap.set('n', '<leader>jeq', function() java_action("source.generate.hashCodeEquals") end,
    { buffer = bufnr, desc = 'Generate HashCode/Equals' })

    -- Implement Interface Methods (<leader>ji)
    vim.keymap.set('n', '<leader>ji', function() java_action("source.overrideMethods") end,
    { buffer = bufnr, desc = 'Implement Methods' })
    -- Java-specific refactorings
    vim.keymap.set('n', '<leader>jo', jdtls.organize_imports, { buffer = bufnr, desc = 'Organize imports' })
    vim.keymap.set('n', '<leader>jv', jdtls.extract_variable, { buffer = bufnr, desc = 'Extract variable' })
    vim.keymap.set('v', '<leader>jv', [[<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>]],
    { buffer = bufnr, desc = 'Extract variable' })
    vim.keymap.set('n', '<leader>jc', jdtls.extract_constant, { buffer = bufnr, desc = 'Extract constant' })
    vim.keymap.set('v', '<leader>jc', [[<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>]],
    { buffer = bufnr, desc = 'Extract constant' })
    vim.keymap.set('v', '<leader>jm', [[<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>]],
    { buffer = bufnr, desc = 'Extract method' })
  end,
}

-- Start jdtls
jdtls.start_or_attach(config)
