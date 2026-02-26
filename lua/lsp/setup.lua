-- @p lua/lsp/setup.lua
-- ╭──────────────────────────────────────────────────────────╮
-- │                        LSP Setup                         │
-- ╰──────────────────────────────────────────────────────────╯

-- { Diagnostics UI {{{
vim.diagnostic.config({
  virtual_text = { prefix = '●', spacing = 4 },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
-- }}}

-- { Diagnostics Keymaps {{{
vim.keymap.set('n', '<leader>sd', function()
  vim.diagnostic.open_float(nil, {
    focusable = false,
    border = 'rounded',
    scope = 'line',
    source = 'if_many',
    header = 'Diagnostics',
  })
end, { desc = 'Show diagnostics (line)' })
-- }}}

-- { LSP Keymaps {{{
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
-- }}}
