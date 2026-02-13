---@brief
---
--- https://github.com/bash-lsp/bash-language-server
---
--- `bash-language-server` can be installed via `npm`:
--- ```sh
--- npm i -g bash-language-server
--- ```
---
--- Language server for bash, written using tree sitter in typescript.

local cmd = require("helpers.lsp")
local capabilities = require("helpers.capabilities").get_capabilities()

-- │ @BASHLS_CONFIG │

---@type vim.lsp.Config
return {
  cmd = { cmd.get_cmd('bashls', 'bash-language-server'), 'start' },
  capabilities = capabilities,
  settings = {
    bashIde = {
      -- Glob pattern for finding and parsing shell script files in the workspace.
      -- Used by the background analysis features across files.

      -- Prevent recursive scanning which will cause issues when opening a file
      -- directly in the home directory (e.g. ~/foo.sh).
      --
      -- Default upstream pattern is "**/*@(.sh|.inc|.bash|.command)".
      globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
    },
  },
  filetypes = { 'bash', 'sh' },
  root_markers = { '.git' },
}
