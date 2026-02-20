-- @p lua/snippets/java.lua
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local rep = extras.rep

return {
  s({ trig = "main", snippetType = "autosnippet"},
    fmta(
      [[
      public static void main(String[] args) {
          <>
      }
      ]], { i(1) }
    )
  ),
  s({ trig = "psv", snippetType = "autosnippet" },
    fmta(
      [[
      public static void <>(<>) {
          <>
      }
      ]], { i(1, "methodName"), i(2), i(0) }
    )
  ),
  s({ trig = "psi", snippetType = "autosnippet" },
    fmta(
      [[
      public static int <>(<>) {
          <>
      }
      ]], { i(1, "methodName"), i(2), i(0) }
    )
  ),
  s({ trig = "list(%u%l*)", regTrig = true, snippetType = "snippet" },
    fmt("List<{}> {} = new ArrayList<{}>();", {
      d(1, function(_, snip)
        return sn(nil, { i(1, snip.captures[1] or "String") })
      end),
      i(2, "list"),
      rep(1)
    })
  ),
  s({ trig = "print", snippetType = "autosnippet" },
    fmta(
      [[
      System.out.print(<>)
      ]],
      { i(0) }
    )
  ),
}
