-- @p lua/custom/surround.lua
-- ╭──────────────────────────────────────────────────────────╮
-- │                       Surround                           │
-- ╰──────────────────────────────────────────────────────────╯
-- This "native plugin" is kind of a try to achieve the same behavior as vim-surround
-- (@l https://github.com/tpope/vim-surround ) but at the end it may not work as
-- expected sometimes, like, i couldn't make it so that it would wait till the surrounder
-- was selected (pressed), so you gotta be a little fast for it to work.

vim.keymap.set({ "v" }, 'gs"', 'c"<C-r>""<Right><Esc>', { noremap = true })
vim.keymap.set({ "v" }, 'gs(', 'c(<C-r>")<Right><Esc>', { noremap = true })
vim.keymap.set({ "v" }, 'gs[', 'c[<C-r>"]<Right><Esc>', { noremap = true })
vim.keymap.set({ "v" }, 'gs{', 'c{<C-r>"}<Right><Esc>', { noremap = true })
vim.keymap.set({ "v" }, 'gs_', 'c_<C-r>"_<Right><Esc>', { noremap = true })
vim.keymap.set({ "v" }, 'gs*', 'c*<C-r>"*<Right><Esc>', { noremap = true })

local patterns = {'a', 'i'}

for _, pat in ipairs(patterns) do
  vim.keymap.set("n", 'ys' .. pat .. 'w', 'v' .. pat .. 'wgs', { remap = true })
end
