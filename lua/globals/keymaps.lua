-- @p lua/globals/keymaps.lua
-- ╭──────────────────────────────────────────────────────────╮
-- │                        Keymaps                           │
-- ╰──────────────────────────────────────────────────────────╯
vim.g.mapleader = " "
local map = vim.keymap.set

-- { Defaults {{{
map("n", "<leader>pl", vim.cmd.Ex, { desc = "Open File Explorer (netrw)" })
map("i", "jj", "<Esc>", { noremap = true, silent = true, desc = "Escape Insert Mode" })
map("n", "<leader>so", ":update<CR> :source<CR>", { desc = "Save and Source File" })
map("n", "<leader>lf", vim.lsp.buf.format, { desc = "Trigger Language Format" })
map("n", "<leader>==", "ggVG=", { desc = "Indent whole file 'correctly'"})
-- }}}

-- { Emmet {{{
vim.g.user_emmet_mode = 'a'
vim.g.user_emmet_leader_key = ','
-- }}}

-- { ThePrimeagen's Keymaps } --
-- Centering function
local function center_map(mode, combo, command, opts)
  map(mode, combo, command .. "zz", opts)
end

--  { Moving things arround {{{
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Selected Block Down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Selected Block Up" })
-- }}}

-- { Centering navigation {{{
center_map("n", "<C-d>", "<C-d>", { desc = "Move Half Page Down" })
center_map("n", "<C-u>", "<C-u>", { desc = "Move Half Page Up" })
map("n", "n", "nzzzv", { desc = "Next Search Match" })
map("n", "N", "Nzzzv", { desc = "Previous Search Match" })
-- }}}

-- { Yanking, Pasting, and Deleting {{{
map('n', '<leader>v', "\"+p", { desc = "Paste From Clipboard" })
map("x", "<leader>p", "\"_dP", { desc = "Paste But Save What Was On The Register" })

map("n", "<leader>y", "\"+y", { desc = "Yank to Clipboard (normal)" })
map("v", "<leader>y", "\"+y", { desc = "Yank to Clipboard (visual)" })
map("n", "<leader>y", "\"+Y")

map("n", "<leader>d", "\"_d", { desc = "Delete to Clipboard (normal)" })
map("v", "<leader>d", "\"_d", { desc = "Delete to Clipboard (visual)" })
-- }}}

-- { WTH {{{
map("n", "Q", "<nop>")
map("i", "<C-c>", "<Esc>", { desc = "Escape Visual Mode" })
-- }}}

-- { Navigating WARN {{{
center_map("n", "<C-k>", "<cmd>cnext<CR>", { desc = "Go to Next Diagnostic" })
center_map("n", "<C-j>", "<cmd>cprev<CR>", { desc = "Go to Previous Diagnostic" })
center_map("n", "<leader>k", "<cmd>lnext<CR>")
center_map("n", "<leader>j", "<cmd>lprev<CR>")
-- }}}

-- { Some REGEXes and Stuff {{{
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { desc = "Select and Change Word Under Cursor (File Wise)" })
map("v", "<leader>s", "\"hy:%s#<C-r>h#<C-r>h#gI<Left><Left><Left>",
  { desc = "Select and Change Selected Text (File Wise)" })
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Turn File Into an Executable" })
map("n", "<leader>r", ":s/\\s\\+/\\r/g", { desc = "Spread Line Into Next Lines (per contiguous text)" })
map("n", "<leader>z", "_izx<Esc>u", { desc = "Force Fold Enable" })
map("v", '<leader>bf', 'c{{{<CR><Esc>0p<Up>dd<Up>0%gcc$%gcc0<Right><Right>i<Space>{<Right><C-h><Space>',
  { remap = true, desc = "Make a Block foldable and insert a title" })
-- }}}
-- {    } --

-- { Lazy Typings {{{
map("o", "i9", "i(", { noremap = true, desc = "Shorter Change Inside Paragraph" })
map("o", "ii", "i[", { noremap = true, desc = "Shorter Change Inside Brackets" })
map("o", "io", "i{", { noremap = true, desc = "Shorter Change Inside Braces" })
map("o", "a9", "a(", { noremap = true, desc = "Shorter Change Around Paragraph" })
map("o", "ai", "a[", { noremap = true, desc = "Shorter Change Around Brackets" })
map("o", "ao", "a{", { noremap = true, desc = "Shorter Change Around Braces" })
-- }}}

-- { File Stuff {{{
map("n", '<leader>cr', '<cmd>let @+ = fnamemodify(expand("%"), ":.")<CR>',
  { desc = 'Copy the relative path to the "current" file' })
map("n", '<leader>cp', '<cmd>let @+ = expand("%:p")<CR>',
  { desc = 'Copy the absolute path to the "current" file' })
map("n", '<leader>pf', 'i@p<Space><Esc><Space>cp"+p_/nvim<CR>f/vF@f/dgcc:w<CR>',
  { remap = true, desc = "Add File Path Headers to Config Files" })
map("n", '<leader>pp', 'i@p<Space><Esc><Space>cr"+pgcc:w<CR>',
  { remap = true, desc = "Add File Path Headers" })
-- }}}
