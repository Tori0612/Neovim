setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab

setlocal commentstring=//\ %

setlocal makeprg=javac\ %

nnoremap <buffer> <leader>r :w<CR>:!javac % && java %:r<CR>
