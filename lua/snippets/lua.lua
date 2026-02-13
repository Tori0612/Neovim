-- @p lua/snippets/lua.lua
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmta = require("luasnip.extras.fmt").fmta

return {
  s("modeline", {
    t("-- "),
    t("vim:"),
    t(" foldmethod=marker")
  }),
  s({ trig = "TITLE", sippetType = "autosnippet"},
    fmta(
      [[
      -- ╭──────────────────────────────────────────────────────────╮
      -- │                            <>                            │
      -- ╰──────────────────────────────────────────────────────────╯
      ]], { i(1) }
    )
  ),
}
