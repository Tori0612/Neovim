-- @p lua/plugins/colorscheme.lua
local gh = require('helpers.github').gh

vim.pack.add({
  { src = gh("catppuccin/nvim") }
})

require("catppuccin").setup({
  flavour = "mocha",

  transparent_background = true,
  color_overrides = {
    mocha = {
      base   = "#161616",
      mantle = "#121212",
      crust  = "#0d0d0d",
    },
  },

  show_end_of_buffer = false,
  term_colors = true,

  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },

  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors      = { "italic" },
        hints       = { "italic" },
        warnings    = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors      = { "underline" },
        hints       = { "underline" },
        warnings    = { "underline" },
        information = { "underline" },
      },
    },
    cmp = true,
    gitsigns = true,
    telescope = true,
    nvimtree = true,
    which_key = true,
  },
})

vim.cmd.colorscheme("catppuccin")
