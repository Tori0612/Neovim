-- @p lua/plugins/markview.lua
local gh = require('utils.github').gh

vim.pack.add({
  gh('nvim-treesitter/nvim-treesitter'),
  gh('OXY2DEV/markview.nvim')
})

local markPresets = require('markview.presets')

local tps = markPresets.tables
local hps = markPresets.headings
-- local rps = require("markview.horizontal_rules").horizontal_rules;
local bps = markPresets.block_quotes

require('markview').setup({
  preview = {
    icon_provider = 'mini'
  },
  markdown = {
    headings = hps.glow,
    -- horizontal_rules = rps.solid,
    tables = tps.double,
  },
  markdown_inline = {
    enable = true,
    inline_codes = {
      enable = true,
      hl = "MarkviewInlineCode",
      virtual = true,
      padding_left = " ",
      padding_right = " ",
    },
    escapes = {
      enable = true,
    },
  }
})
