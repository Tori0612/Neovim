---@brief
--- https://github.com/zigtools/zls
---
--- Zig LSP implementation + Zig Language Server

local zig_path = vim.env.ZIG_PATH or "zig"

local cmd = require("helpers.lsp")
local capabilities = require("helpers.capabilities").get_capabilities()

-- │ @ZLS_CONFIG │
---@type vim.lsp.Config
return {
  cmd = { cmd.get_cmd("zls", 'zls') },
  capabilities = capabilities,
  filetypes = { 'zig', 'zir' },
  root_markers = { 'zls.json', 'build.zig', '.git' },
  workspace_required = false,
  settings = {
    zig = {
      zigPath = vim.fn.expand(zig_path),
    }
  }
}
