" @p after/ftplugin/toc.vim
" setlocal buftype=nofile
" setlocal bufhidden=wipe
" setlocal noswapfile
setlocal nobuflisted
setlocal nowrap
setlocal cursorline
setlocal conceallevel=2
setlocal concealcursor=nvic

nnoremap <buffer> <silent> <CR> <CR>:lclose<CR>
nnoremap <buffer> <silent> q :lclose<CR>
