-- @p lua/globals/options.lua
-- ╭──────────────────────────────────────────────────────────╮
-- │                       Options                            │
-- ╰──────────────────────────────────────────────────────────╯
-- { Paths That need to be declared globally {{{
if vim.env.PYTHON_PATH then
  vim.g.python3_host_prog = vim.fn.expand(vim.env.PYTHON_PATH)
end
-- }}}

local function apply_options(options)
  for k, v in pairs(options) do
    vim.opt[k] = v
  end
end

-- { LEADER {{{
vim.g.mapleader = " "
-- }}}

-- { Appearance {{{
local appearance = {
  nu = true,              relativenumber = true,
  guicursor = "",         cursorline = true,
  winborder = "double",   tabstop = 4,
  softtabstop = 4,        shiftwidth = 4,
  signcolumn = "number",  termguicolors = true,
  splitright = true,      splitbelow = true,
  conceallevel = 2,       concealcursor = 'nc',
}
-- }}}

-- { Visual Configs (that are not necessarily appearance) {{{
local visual = {
  expandtab = true,     autoindent= true,
  smartindent = false,  cindent = false,
  wrap = false,         scrolloff = 10,
}
-- }}}

-- { Weird Settings {{{
local behavior = {
  swapfile = false,     backup = false,
  writebackup = false,  backupcopy = "yes",
  undofile = true,
}

local undodir = vim.fn.stdpath("state") .. "/undo"
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
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
local fold = {
  shadafile = vim.fn.stdpath("data") .. "/shada/main.shada",
  foldenable = false,     foldlevel = 99,
  hlsearch = false,       incsearch = true,
  updatetime = 50,
}
vim.opt.isfname:append("@-@")
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

-- { Vimtex Configs {{{
vim.g.vimtex_view_method = 'zathura'

vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_callback_progpath = 'nvim'
vim.g.vimtex_compiler_latexmk = {
    options = {
        '-pdf',
        '-interaction=nonstopmode',
        '-synctex=1',
    },
}
vim.g.vimtex_quickfix_mode = 0
-- }}}

-- { Applying Options {{{
apply_options(appearance)
apply_options(visual)
apply_options(behavior)
apply_options(fold)
-- }}}
