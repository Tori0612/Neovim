-- @p lua/snippets/xml.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("xml", {
  -- Full Service Template
  s("service", {
    t({'<?xml version="1.0" encoding="UTF-8"?>', ""}),
    t('<list name="'), i(1, "Service"), t({'">', "\t"}),
    t('<item type="music" title="'), i(2, "First Song"), t({'"/>', "\t"}),
    t('<item type="music" title="'), i(3, "Second Song"), t({'"/>', ""}),
    t('<item type="music" title="'), i(4, "Third Song"), t({'"/>', ""}),
    t('</list>'),
  }),

  -- Quick item entry
  s("item", {
    t('<item type="music" title="'), i(1, "Song Title"), t('"/>'),
  }),
})
