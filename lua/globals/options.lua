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
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.opt.undofile = true
-- }}}

-- { Folding and Some More Weird settings {{{
vim.opt.foldmethod= 'expr' -- these folding seem to not work that well, but there's the keymap <leader>z, it has been solving it
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

-- vim: foldmethod=marker
