-- @p lua/helpers/capabilities.lua
-- This helper gets the client capabilities and uses it either as a
-- fallback or your main capabilities, there ones implemented locally should
-- be used with the local completion on @p lua/globals/completion.lua , but i dont
-- quite recommend it yet, there are issues listed there, just uncomment one and comment
-- the other to switch, to see more about how to switch between completions check on
-- @p lua/globals/completion.lua or in @p lua/plugins/cmp.lua

local M = {}

M.get_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- { Local Capabilities {{{
--  capabilities.textDocument.completion.completionItem.snippetSupport = true
--  capabilities.textDocument.completion.completionItem.resolveSupport = {
--    properties = { "documentation", "detail", "additionalTextEdits" },
--  }
  -- }}}

  -- { Blink Capabilities {{{
   local has_blink, blink = pcall(require, "blink.cmp")
   if has_blink then
     return blink.get_lsp_capabilities(capabilities)
   end
  -- }}}

  return capabilities
end

return M
