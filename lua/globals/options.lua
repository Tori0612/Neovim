-- @p lua/globals/options.lua
-- ╭──────────────────────────────────────────────────────────╮
-- │                       Options                            │
-- ╰──────────────────────────────────────────────────────────╯
-- { Paths That need to be declared globally {{{
if vim.env.PYTHON_PATH then
  vim.g.python3_host_prog = vim.fn.expand(vim.env.PYTHON_PATH)
end
-- }}}

-- { LEADER {{{
vim.g.mapleader = " "
-- }}}

-- { Appearance {{{
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.guicursor = ""
vim.opt.cursorline = true
vim.opt.winborder = "double"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "number"
vim.opt.termguicolors = true
vim.opt.splitright = true
vim.opt.splitbelow = true
-- }}}

-- { Visual Configs (that are not necessarily appearance) {{{
vim.opt.expandtab = true
vim.opt.autoindent= true
vim.opt.smartindent = false
vim.opt.cindent = false
vim.opt.wrap = false
vim.opt.scrolloff = 10
-- }}}

-- { Weird Settings {{{
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.backupcopy = "yes"
vim.opt.undofile = true
local undodir = vim.fn.stdpath("state") .. "/undo"
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mdkir(undodir, "p")
end
vim.opt.undodir = undodir
-- }}}

-- { Clojure Specific Configs {{{
vim.g["conjure#log#wrap"] = false
vim.g["conjure#log#hud#enabled"] = true
vim.g["conjure#log#botright"] = true
vim.g["conjure#log#split"] = "right"
vim.g["conjure#log#width"] = 0.42

vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
-- }}}}

-- { Folding and Some More Weird settings {{{
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.o.shadafile = vim.fn.stdpath("data") .. "/shada/main.shada"
-- }}}

-- { Yank Highlighting (TJ's doing) {{{
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#f4bf75", bold = true })
-- }}}

-- { Indenting Changes {{{
vim.api.nvim_create_autocmd("FileType", {
    pattern = { 'html', 'css', 'scss', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'json', 'lua' },
    callback = function ()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop= 2
        vim.opt_local.softtabstop = 2
    end,
})
-- }}}
