---@brief
---
--- https://github.com/eclipse/lemminx
---
--- The easiest way to install the server is to get a binary from https://github.com/redhat-developer/vscode-xml/releases and place it on your PATH.
---
--- NOTE to macOS users: Binaries from unidentified developers are blocked by default. If you trust the downloaded binary, run it once, cancel the prompt, then remove the binary from Gatekeeper quarantine with `xattr -d com.apple.quarantine lemminx`. It should now run without being blocked.
local cmd = require("lsp.cmd")
local capabilities = require("lsp.capabilities").get_capabilities()

-- │ @LEMMINX_CONFIG │
---@type vim.lsp.Config
return {
  cmd = { cmd.get_cmd('lemminx', 'lemminx') },
  capabilities = capabilities,
  filetypes = { 'xml', 'xsd', 'xsl', 'xslt', 'svg' },
  root_markers = { '.git' },
}
