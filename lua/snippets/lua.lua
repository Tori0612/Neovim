-- @p lua/snippets/lua.lua
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmta = require("luasnip.extras.fmt").fmta

return {
  s({ trig = "TITLE", sippetType = "autosnippet"},
    fmta(
      [[
      -- ╭──────────────────────────────────────────────────────────╮
      -- │                            <>                            │
      -- ╰──────────────────────────────────────────────────────────╯
      ]], { i(1) }
    )
  ),
  s({ trig = "map", snippetType = "snippet" },
    fmta(
      [[
      map("<>", "<>", <>, <>)
      ]],
      { i(1, "mode"), i(2, "combo"), i(3, "command"), i(0)}
  )),
  s({ trig = "lmap", snippetType = "snippet" },
    fmta(
      [[
      map("<>", "<<leader>><>", <>, <>)
      ]],
      { i(1, "mode"), i(2, "combo"), i(3, "command"), i(0)}
  )),
}
