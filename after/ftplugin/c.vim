setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab

setlocal commentstring=//\ %s

setlocal makeprg=gcc\ %\ -Wall\ -Wextra\ -02\ -o\ %:r

if has('win32') || has('win64')
    nnoremap <buffer> <leader>rr :w<CR>:!gcc % -o %<.exe && %<.exe<CR>
    nnoremap <buffer> <leader>rc :w<CR>:!gcc % -o %<.exe<CR>
    nnoremap <buffer> <leader>re :!%<.exe<CR>
else
    nnoremap <buffer> <leader>rr :w<CR>:!gcc % -o %:r && %:r<CR>
    nnoremap <buffer> <leader>rc :w<CR>:!gcc % -o %:r<CR>
    nnoremap <buffer> <leader>re :!%:r<CR>
endif
