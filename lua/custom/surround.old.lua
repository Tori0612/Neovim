-- @p lua/custom/surround.lua
--
-- ╭──────────────────────────────────────────────────────────╮
-- │                       Surround                           │
-- ╰──────────────────────────────────────────────────────────╯
--
-- This "native plugin" is kind of a try to achieve the same behavior as vim-surround
-- (@l https://github.com/tpope/vim-surround ) but at the end it may not work as
-- expected sometimes, like, i couldn't make it so that it would wait till the surrounder
-- was selected (pressed), so you gotta be a little fast for it to work. At the end of the day,
-- it does pretty much of what it is suposed to do, if i'm not mistaken, on `vim-surround` if the,
-- selected code is already surrounded it changes the surrounding, i couldn't achieve it, but i made
-- a different keymap to change (turn) the surrouding.
-- 
-- { Keymaps }
-- s -> surrounds with something
-- e.g. you can do `s"` and it surrounds something with double quotes
-- something coded ==> "something coded"
--
-- ys[...] -> surrounds 'inside' or 'arround' a word with something (normally arround is not used)
-- e.g. you can do `ysiw[` to surround a word with brackets
-- something ==> [something]
--
-- sr -> turns the surrounding into another
-- e.g. you can do `sr(` on a code surrounded with brackets and it turns into a code surrounded with parenthesis
-- [something] ==> (something)
-- 
-- yr[...] -> turns the surrounding of a code 'inside' a surrounder.
-- e.g. you can do `yr[(` on a code surrounded by brackets to change the surrounder to parenthesis
-- [something coded] ==> (something coded)

local map = require("utils.map")

local actions = {
                  { open = "'", close = "'" },
                  { open = '"', close = '"' },
                  { open = '(', close = ')' },
                  { open = '[', close = ']' },
                  { open = '{', close = '}' },
                }

local markdown = {
  b = "**",  -- bold
  i = "_",   -- italic
  l = "$",   -- latex (math)
  c = "`",  -- code
}

-- s
-- sr

local utils = { main_reg = '<C-r>"', leave_esc = '<Right><Esc>', delete_additional = '<Right><C-h><C-h>' }
local patterns = { arround = 'a', inside = 'i' }
local matches = { '"', '(', '[', '{', 'w' }
-- something in italic:  **bold**
for key, mark in pairs(markdown) do
  map.v('s' .. key, 'c' .. mark .. utils.main_reg .. mark .. utils.leave_esc,
    { noremap = true, desc = "(Go Surround) surrounds the selected code with a desired markdown styler"})
  map.v('sr' .. key, 'c' .. utils.delete_additional .. mark .. utils.main_reg .. mark .. utils.leave_esc,
    { noremap = true, desc = "(Go Turn) turns styler of the selected code into another styler"})
  map.v('ssr' .. key, 'c' .. utils.delete_additional .. utils.delete_additional .. mark .. utils.main_reg .. mark .. utils.leave_esc,
    { noremap = true, desc = "(Go Turn) turns styler (any double) of the selected code into another styler"})
  for name, pat in pairs(patterns) do
    for _, mat in ipairs(matches) do
      map.n("ys" .. pat .. mat, "v" .. pat .. mat .. 's', { remap = true })
      -- `cash`
      if name == "inside" then
        for k, _ in pairs(markdown) do
          map.n('yr' .. key .. k, 'v' .. pat .. 'w' .. 'sr' .. k, { remap = true })
          if key == 'b' then
            map.n('yr' .. key .. k, 'v' .. pat .. 'w' .. 'ssr' .. k, { remap = true })
          end
        end
      end
    end
  end
end

for _, act in ipairs(actions) do
  map.v('s' .. act.open, 'c' .. act.open .. utils.main_reg .. act.close .. utils.leave_esc,
    { noremap = true, desc = "(Go Surround) surrounds the selected code with a desired symbol" })
  map.v('sr' .. act.open, 'c' .. utils.delete_additional .. act.open .. utils.main_reg .. act.close .. utils.leave_esc,
    { noremap = true, desc = "(Go Turn) turns the surrounding of a selected code into another surrounding" })
  for name, pat in pairs(patterns) do
    if name == "inside" then
      for _, aa in ipairs(actions) do
        map.n("yr" .. act.open .. aa.open, 'v' .. pat .. act.open .. 'sr' .. aa.open, { remap = true })
      end
    end
  end
end

for _, pat in pairs(patterns) do
  for _, match in ipairs(matches) do
    map.n('ys' .. pat .. match, 'v' .. pat .. match .. 's', { remap = true })
  end
end
