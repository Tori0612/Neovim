local jdtls = require('jdtls')

-- Find root FIRST (Move this up so we can use it for the workspace name)
local root_markers = {'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}
local root_dir = require('jdtls.setup').find_root(root_markers)

-- Safety check: If no root found, don't start
if root_dir == "" then return end

-- Find jdtls installation (Mason)
local jdtls_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
local launcher = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')

local system = 'linux'
local config_path = jdtls_path .. '/config_' .. system

-- FIX: Use the folder name of the EXERCISE (root_dir) as the workspace name
-- This ensures 'Sandbox' gets its own workspace, and 'AdaLovelace' gets its own.
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
    '-data', workspace_dir, -- This is now unique per exercise!
  },

  root_dir = root_dir,

  capabilities = capabilities, -- Ensure you have this defined in your generic LSP setup
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
    -- Helper function to trigger specific code actions
    local function java_action(kind)
      vim.lsp.buf.code_action({
        context = {
          only = { kind }, -- Filter: Only show actions of this specific kind
          diagnostics = {}, -- Don't include error fixes, just the action
        }
      })
    end
    -- 1. Generate Getters and Setters (<leader>jg)
    vim.keymap.set('n', '<leader>jg', function() java_action("source.generate.accessors") end,
      { buffer = bufnr, desc = 'Generate Getters/Setters' })

    -- 2. Generate Constructor (<leader>jco)
    vim.keymap.set('n', '<leader>jco', function() java_action("source.generate.constructors") end,
      { buffer = bufnr, desc = 'Generate Constructor' })

    -- 3. Generate toString() (<leader>jts)
    vim.keymap.set('n', '<leader>jts', function() java_action("source.generate.toString") end,
      { buffer = bufnr, desc = 'Generate toString' })

    -- 4. Generate hashCode() and equals() (<leader>jeq)
    vim.keymap.set('n', '<leader>jeq', function() java_action("source.generate.hashCodeEquals") end,
      { buffer = bufnr, desc = 'Generate HashCode/Equals' })

    -- 5. Implement Interface Methods (CRITICAL for Part 9+) (<leader>ji)
    -- This fixes the "The type Must implement the inherited abstract method" error
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
