" @p after/ftplugin/lua.vim
setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab
setlocal foldmethod=marker

setlocal commentstring=--\ %s

nnoremap <buffer> <leader>rr :w<CR>:luafile %<CR>
nnoremap <buffer> <leader>lf :lua vim.lsp.buf.format()<CR>
