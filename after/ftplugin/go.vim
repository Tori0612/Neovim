" @p after/ftplugin/go.vim
setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab  " Go uses tabs

autocmd BufWritePre <buffer> silent! lua vim.lsp.buf.format()

nnoremap <buffer> <leader>rr :w<CR>:call termutils#Run("go run %")<CR>
nnoremap <buffer> <leader>rb :w<CR>:call termutils#Run("go build")<CR>
nnoremap <buffer> <leader>rt :w<CR>:call termutils#Run("go test")<CR>

iabbrev <buffer> ierr if err != nil {<CR>return err<Esc>

nnoremap <buffer> <leader>ii :GoImpl<CR>

setlocal makeprg=go\ run\ %

setlocal commentstring=//\ %s
