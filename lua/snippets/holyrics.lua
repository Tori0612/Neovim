-- @p lua/snippets/json.lua (ou holyrics.lua)
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmta = require("luasnip.extras.fmt").fmta

return {
  -- Snippet para o esqueleto inicial da música
  s({ trig = "hheader", snippetType = "snippet" },
    fmta(
      [[
{
  "title": "",
  "artist": "",
  "author": "",
  "key": "",
  "order": "",
  "lyrics": {
    "full_text": "",
    "paragraphs": [
      {
        "number": 1,
        "description": "V1",
        "text": "<>"
      }
      ]], { i(0) }
    )
  ),

  -- Snippet para adicionar parágrafos extras (estrofes)
  s({ trig = "hpara", snippetType = "snippet" },
    fmta(
      [[
      ,{
        "number": <>,
        "description": "<>",
        "text": "<>"
      }<>
      ]], 
      { 
        i(1, "2"),      -- Número da estrofe
        i(2, "C"),      -- Descrição (C, V2, P, etc)
        i(3),           -- Texto da estrofe
        i(0)            -- Ponto de saída
      }
    )
  ),

  -- Snippet simples para fechar o JSON após o último parágrafo
  s({ trig = "hfooter", snippetType = "snippet" },
    t({
      "",
      "    ]",
      "  }",
      "}"
    })
  ),
}
