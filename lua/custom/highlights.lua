-- @p lua/custom/highlights.lua
-- ╭──────────────────────────────────────────────────────────╮
-- │                        Highlights                        │
-- ╰──────────────────────────────────────────────────────────╯
-- This "native plugin" is simply for some nice header titles like this, for a well documented config.
-- You're prolly never going to use it, but i wanted to put it up here so that i can do it in some places,
-- for example, in the lsp configs i have highlighted the top of the config, only implemented ones (for .env changes)
-- are there, so if no highlight, no implementation, there's also a highlight for file paths, in a way that you can
-- use it to go to file, whenever you see a "reference"

local colors = require("colors.colors")

local function apply_highlights()
  local hl = vim.api.nvim_set_hl
  -- @t [ Header ]
  hl(0, "HeaderRibbon", {
    reverse = true,
    fg = colors.orange,
    bg = colors.bg0,
    bold = true,
    force = true
  })
  -- @t [ Borders ]
  hl(0, "HeaderBorder", { fg = colors.bg2, force = true })

  -- @t [ Folder Header ]
  hl(0, "TocTitleHeader", { fg = colors.green, bold = true })

  -- @t [ LSP Config ]
  hl(0, "LSPMark", { bg = colors.bright_magenta, bold = true, italic = true, fg = "#e6cad2" })

  -- @t [ File Paths ]
  hl(0, "FilePath", { fg = colors.cyan, italic = true })

  -- @t [ Link Urls ]
  hl(0, "LinkUrl", { fg = colors.blue, italic = true })

  -- { StatusLine Colors {{{
  hl(0, "StatusNormal", { fg = colors.bg1, bg = colors.fg0, bold = true })
  hl(0, "StatusInsert", { fg = colors.bg1, bg = colors.blue, bold = true })
  hl(0, "StatusVisual", { fg = colors.bg1, bg = colors.magenta, bold = true })
  hl(0, "StatusCmd",    { fg = colors.bg1, bg = colors.orange, bold = true })
  hl(0, "StatusReplace",{ fg = colors.bg1, bg = colors.red, bold = true })
  hl(0, "StatusEmpty",  { fg = colors.fg0, bg = colors.bg2 })
  -- }}}

  -- { Window Colors {{{
  hl(0, "FloatDarkBg", { bg = colors.bg0, fg = "NONE" })
  hl(0, "FloatDarkBorder", { bg = colors.bg2, fg = "NONE" })
  -- }}}
end

local function apply_matches()
  pcall(vim.fn.clearmatches)

  local ribbon_pat = [[\%u2502\zs\s*\u\+.*\ze\%u2502]]
  local border_pat = '[╭─╮│╰╯]'
  local file_pat = [[@p\s\+\zs\S\+\ze]]
  local link_pat = [[@l\s\+\zs\S\+\ze]]
  local folder_pat = [[--\s*{\s*\zs.\{-}\ze\s*{{{]]
  local title_pat = [=[@t\s*\[\s*\zs.\{-}\ze\s*\]]=]
  local lsp_pat = [[\%u2502\zs\s*@\u\+.*\ze\%u2502]]

  vim.fn.matchadd("HeaderRibbon", ribbon_pat, 150)
  vim.fn.matchadd("HeaderBorder", border_pat, 140)
  vim.fn.matchadd("FilePath", file_pat, 100)
  vim.fn.matchadd("LinkUrl", link_pat, 100)
  vim.fn.matchadd("TocTitleHeader", folder_pat, 110)
  vim.fn.matchadd("TocTitleHeader", title_pat, 110)
  vim.fn.matchadd("LSPMark", lsp_pat, 100)
end

apply_highlights()

-- { AutoCommands {{{
vim.api.nvim_create_autocmd({'FileType', 'BufEnter'}, {
  pattern = "lua",
  callback = function ()
    apply_highlights()
    apply_matches()
  end
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function ()
    apply_highlights()
    apply_matches()
  end
})
-- }}}
