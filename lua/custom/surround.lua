-- @p lua/custom/surround.lua
-- ╭──────────────────────────────────────────────────────────╮
-- │                       Surround                           │
-- ╰──────────────────────────────────────────────────────────╯
-- This "native plugin" is kind of a try to achieve the same behavior as vim-surround
-- (@l https://github.com/tpope/vim-surround ) but at the end it may not work as
-- expected sometimes, like, i couldn't make it so that it would wait till the surrounder
-- was selected (pressed), so you gotta be a little fast for it to work. At the end of the day,
-- it does pretty much of what it is suposed to do, if i'm not mistaken, on `vim-surround` if the,
-- selected code is already surrounded it changes the surrounding, i couldn't achieve it, but i made
-- a different keymap to change (turn) the surrouding.
-- 
-- { Keymaps }
-- gs -> surrounds with something
-- e.g. you can do `gs"` and it surrounds something with double quotes
-- something coded ==> "something coded"
--
-- ys[...] -> surrounds 'inside' or 'arround' a word with something (normally arround is not used)
-- e.g. you can do `ysiw[` to surround a word with brackets
-- something ==> [something]
--
-- gt -> turns the surrounding into another
-- e.g. you can do `gt(` on a code surrounded with brackets and it turns into a code surrounded with parenthesis
-- [something] ==> (something)
-- 
-- yt[...] -> turns the surrounding of a code 'inside' a surrounder.
-- e.g. you can do `yti[(` on a code surrounded by brackets to change the surrounder to parenthesis
-- [something coded] ==> (something coded)

local map = vim.keymap.set

local actions = {
                  { open = '"', close = '"' },
                  { open = '(', close = ')' },
                  { open = '[', close = ']' },
                  { open = '{', close = '}' },
                  { open = '_', close = '_' },
                  { open = '*', close = '*' },
                }

local utils = { main_reg = '<C-r>"', leave_esc = '<Right><Esc>', delete_additional = '<Right><C-h><C-h>' }
local patterns = { arround = 'a', inside = 'i' }

for _, act in ipairs(actions) do
  map("v", 'gs' .. act.open, 'c' .. act.open .. utils.main_reg .. act.close .. utils.leave_esc,
    { noremap = true, desc = "(Go Surround) surrounds the selected code with a desired symbol" })
  map('v', 'gt' .. act.open, 'c' .. utils.delete_additional .. act.open .. utils.main_reg .. act.close .. utils.leave_esc,
    { noremap = true, desc = "(Go Turn) turns the surrounding of a selected code into another surrounding" })
  for name, pat in pairs(patterns) do
    vim.keymap.set("n", 'ys' .. pat .. 'w', 'v' .. pat .. 'wgs', { remap = true })
    if name == "inside" then
      for _, aa in ipairs(actions) do
        map("n", "yt" .. pat .. act.open .. aa.open, 'v' .. pat .. act.open .. 'gt' .. aa.open, { remap = true })
      end
    end
  end
end
