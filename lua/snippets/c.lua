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
  s({ trig = "numeric", snippetType = "snippet" },
    fmta(
      [[
      #include <<stdint.h>>

      typedef int8_t i8;
      typedef int16_t i16;
      typedef int32_t i32;
      typedef int64_t i64;

      typedef uint8_t u8;
      typedef uint16_t u16;
      typedef uint32_t u32;
      typedef uint64_t u64;

      typedef float f32;
      typedef double f64;
      <>
      ]], { i(0) }
    )
  ),
  s({ trig = "printf", snippetType = "snippet" },
    fmta('printf("<>");', { i(0) })
  ),
  s({ trig = "scanf", snippetType = "snippet"},
    fmta('scanf("<>", <>);', { i(1), i(0) })
  )
}
