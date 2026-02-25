-- @p lua/snippets/c.lua
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
  s({ trig = "main", snippetType = "snippet" },
    fmta(
      [[
      int main(<>)
      {
          <>
          return 0;
      }
      ]], { i(1, "params"), i(0) }
    )
  ),
}
