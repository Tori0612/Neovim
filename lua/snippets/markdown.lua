-- @p lua/snippets/markdown.lua
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
  s({ trig = 'code', snippetType = 'snippet' },
    fmta(
      [[

      ```<>
      <>
      ```

      ]], { i(1, "lang"), i(0, 'code')}
    )
  ),
}
