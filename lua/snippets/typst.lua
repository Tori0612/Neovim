-- @p lua/snippets/typst.lua
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local f = ls.function_node
-- local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local fmt = require("luasnip.extras.fmt").fmt
-- local extras = require("luasnip.extras")
-- local rep = extras.rep

return {
  s({ trig = 'code', snippetType = 'snippet' },
    fmta(
      [[
      ```<>
      <>
      ```
      ]], { i(1, "lang"), i(0) }
    )
  )
  ,
  s({ trig = 'catppuccin', snippetType = 'snippet'},
    fmta(
      [[
      #let catppuccin = (
        bg0: rgb("#11111b"),
        bg1: rgb("#181825"),
        fg0: rgb("6c7086"),
        fg1: rgb("#a6adc8"),
        red: rgb("#f38ba8"),
        orange: rgb("#fab387"),
        yellow: rgb("#f9e2af"),
        green: rgb("#a6e3a1"),
        blue: rgb("#89b4fa"),
        purple: rgb("#cba6f7"),
        aqua: rgb("#8ec07c"),
        gray: rgb("#6c7086"),
      )

      #show raw.where(block: true): it =>> block(
        fill: catppuccin.bg0,
        stroke: 0.5pt + catppuccin.bg1,
        inset: 12pt,
        radius: 4pt,
        width: 100%,
        text(
          fill: catppuccin.fg1,
          font: "JetBrainsMono NFM",
          weight: "regular",
          style: "normal",
          size: 9pt,
          align(left, it)
        )
      )
      <>
      ]], { i(0) }
    )
  ),
  s({ trig = "gruvbox", snippetType = "snippet" },
    fmta(
      [[
      #let gruvbox = (
        bg0: rgb("#282828"),
        bg1: rgb("#3c3836"),
        fg0: rgb("#fbf1c7"),
        fg1: rgb("#ebdbb2"),
        red: rgb("#fb4934"),
        orange: rgb("#fe8019"),
        yellow: rgb("#fabd2f"),
        green: rgb("#b8bb26"),
        blue: rgb("#83a598"),
        purple: rgb("#d3869b"),
        aqua: rgb("#8ec07c"),
        gray: rgb("#928374"),
      )

      #show raw.where(block: true): it =>> block(
        fill: gruvbox.bg0,
        stroke: 0.5pt + gruvbox.bg1,
        inset: 12pt,
        radius: 4pt,
        width: 100%,
        text(
          fill: gruvbox.fg1,
          font: "JetBrainsMono NFM",
          weight: "regular",
          style: "normal",
          size: 9pt,
          align(left, it)
        )
      )
      <>
      ]], { i(0) }
    )
  )
}
