---@brief
---
--- https://github.com/gleam-lang/gleam
---
--- A language server for Gleam Programming Language.
---
--- It comes with the Gleam compiler, for installation see: [Installing Gleam](https://gleam.run/getting-started/installing/)

local capabilities = require("helpers.capabilities").get_capabilities()

-- │ @GLEAM_CONFIG │
---@type vim.lsp.Config
return {
  cmd = { 'gleam', 'lsp' },
  capabilities = capabilities,
  filetypes = { 'gleam' },
  root_markers = { 'gleam.toml', '.git' },
}
