setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab

setlocal commentstring=//\ %s

setlocal makeprg=gcc\ %\ -Wall\ -Wextra\ -02\ -o\ %:r

nnoremap <buffer> <leader>rr :w<CR>:!gcc % -o %:r && ./%:r<CR>
