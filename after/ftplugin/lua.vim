" after/ftplugin/lua.vim
if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab

setlocal commentstring=--\ %s

nnoremap <buffer> <leader>rr :w<CR>:luafile %<CR>
nnoremap <buffer> <leader>lf :lua vim.lsp.buf.format()<CR>
