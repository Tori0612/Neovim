-- @p lua/snippets/python.lua
local ls = require("luasnip")
local extras = require("luasnip.extras")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = extras.rep

-- List of Snippets:
-- @l main      ⇨ main guard
-- @l forenum   ⇨ for loop in an enumerate
-- @l forrange  ⇨ for loop in a range
-- @l forzip    ⇨ for loop with zip
-- @l lambda    ⇨ lambda (normal)
-- @l dictcmp   ⇨ dictionary comprehension
-- @l ifdictcmp ⇨ dictionary comprehension (with condition)
-- @l listcmp   ⇨ list comprehension
-- @l iflistcmp ⇨ list comprehension (with condition)

return {
  s({ trig = "main", snippetType = "autosnippet" },
    fmta(
      [[
      if __name__ = "__main__":
          <>
      ]],
      { i(0) })),
  s({ trig = "forenum", snippetType = "autosnippet" },
    fmta(
      [[
      for <>, <> in enumerate(<>):
        <>
      ]],
      { i(1, "index"), i(2, "value"), i(3, "iterable"), i(0) }
    )),
  s({ trig = "forrange", snippetType = "autosnippet" },
    fmta(
      [[
      for <> in range(<>, <>, <>):
        <>
      ]],
      {
        i(1, "value"), i(2, "start"),
        i(3, "stop"), i(4, "step"),
        i(0),
      })),
  s({ trig = "forzip", snippetType = "autosnippet" },
    fmta(
      [[
      for <>, <> in zip(<>, <>):
        <>
      ]],
      {
        i(1, "value_1"), i(2, "value_2"),
        i(3, "iterable_1"), i(4, "iterable_2"),
        i(0),
      })),
  s({ trig = "whiletrue", snippetType = "autosnippet" },
    fmta(
      [[
      while True:
        if <>:
          break
      ]], { i(0, "condition") }
    )
  ),
  s({ trig = "lambda", snippetType = "snippet" },
    fmta(
      [[
      lambda <>: <>
      ]], { i(1, "args"), i(0, "body") }
    )
  ),
  s({ trig = "groupby", snippetType = "snippet" },
    fmta(
      [[
      groups = defaultdict(list)
      
      for <>, <> in <>:
        groups[<>].append(<>)
        <>
      ]],
      {
        i(1, "value_1"),
        i(2, "value_2"),
        i(3, "iterable"),
        rep(2),
        rep(1),
        i(0),
      }
    )
  ),
  s({ trig = "dictcmp", snippetType = "autosnippet" },
    fmta(
      [[
      {<>: <> for <> in <>}
      <>
      ]],
      {
        i(1, "key_expression"),
        i(2, "value_expression"),
        i(3, "item"),
        i(4, "iterable"),
        i(0),
      }
    )
  ),
  s({ trig = "ifdictcmp", snippetType = "autosnippet" },
    fmta(
      [[
      {<>: <> for <> in <> if <>}
      <>
      ]],
      {
        i(1, "key_expression"),
        i(2, "value_expression"),
        i(3, "item"),
        i(4, "iterable"),
        i(5, "condition"),
        i(0),
      }
    )
  ),
  s({ trig = "listcmp", snippetType = "autosnippet" },
    fmta(
      [[
      [<> for <> in <>]
      <>
      ]],
      {
        i(1, "expression"),
        i(2, "item"),
        i(3, "iterable"),
        i(0),
      }
    )
  ),
  s({ trig = "iflistcmp", snippetType = "autosnippet" },
    fmta(
      [[
      [<> for <> in <> if <>]
      <>
      ]],
      {
        i(1, "expression"),
        i(2, "item"),
        i(3, "iterable"),
        i(4, "condition"),
        i(0),
      }
    )
  ),
}
