-- @p lua/globals/vimtex.lua

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
