-- @p lua/plugins/cmp.lua
local gh = require('utils.github').gh
vim.pack.add({
  { src = gh('saghen/blink.lib') },
  { src = gh('saghen/blink.cmp') },
})

require("blink.cmp").setup({
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    keymap = {
      preset = 'default',
      ['ç'] = { 'accept', 'fallback' },
    },
    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = { documentation = { auto_show = true, auto_show_delay_ms = 200 } },
    cmdline = {
      keymap = {
        preset = 'cmdline',
        ['ç'] = {
          function(cmp)
            return cmp.show_and_insert_or_accept_single({ callback = function()
              vim.api.nvim_feedkeys(' ', 'i', true)
              vim.schedule(cmp.show)
            end })
          end,
          'accept',
        }
      },
      completion = {
        menu = {
          auto_show = true,
        },
      }
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "lua" },
    snippets = {
      preset = 'luasnip'
    },
})
