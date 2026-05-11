---@brief
---
--- https://github.com/clojure-lsp/clojure-lsp
---
--- Clojure Language Server

local cmd = require("helpers.lsp")
local capabilities = require("helpers.capabilities").get_capabilities()

-- │ @CLOJURE_LSP_CONFIG│
---@type vim.lsp.Config
return {
  cmd = { cmd.get_cmd('clojure-lsp', "clojure-lsp") },
  capabilities = capabilities,
  filetypes = { 'clojure', 'edn' },
  root_markers = { 'project.clj', 'deps.edn', 'build.boot', 'shadow-cljs.edn', '.git', 'bb.edn' },
}
