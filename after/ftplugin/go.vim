" after/ftplugin/go.vim
setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab  " Go uses tabs

autocmd BufWritePre <buffer> silent! lua vim.lsp.buf.format()

nnoremap <buffer> <leader>rr :!go run %<CR>
nnoremap <buffer> <leader>rb :!go build<CR>
nnoremap <buffer> <leader>rt :!go test<CR>

iabbrev <buffer> ierr if err != nil {<CR>return err<Esc>

nnoremap <buffer> <leader>ii :GoImpl<CR>

setlocal commentstring=//\ %s
