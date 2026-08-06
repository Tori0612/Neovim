-- @p lua/snippets/sh.lua
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
  s({ trig = 'bin', snippetType = 'snippet' },
    fmta(
      [[
      #!/bin/bash
      <>
      ]], { i(0, "") }
    )
  )
}
