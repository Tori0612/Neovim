" @p after/ftplugin/c.vim
setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab

setlocal commentstring=//\ %s
setlocal foldmethod=marker
setlocal foldmarker='[[[,]]]'

setlocal makeprg=gcc\ %\ -Wall\ -Wextra\ -02\ -o\ %:r

if has('win32') || has('win64')
    nnoremap <buffer> <leader>rr :w<CR>:!gcc % -o %<.exe && %<.exe<CR>
    nnoremap <buffer> <leader>rc :w<CR>:!gcc % -o %<.exe<CR>
    nnoremap <buffer> <leader>re :!%<.exe<CR>
else
    nnoremap <buffer> <leader>rr :w<CR>:call termutils#Run("mkdir -p bin && gcc % -o bin/n && bin/n")<CR>
    nnoremap <buffer> <leader>rm :w<CR>:call termutils#Run("mkdir -p bin && gcc % -lm -o bin/n && bin/n")<CR>
    nnoremap <buffer> <leader>rc :w<CR>:call termutils#Run("mkdir -p bin && gcc % -o bin/n")<CR>
    nnoremap <buffer> <leader>re :call termutils#Run("bin/n")<CR>
    nnoremap <buffer> <leader>ro :w<CR>:call termutils#Run("mkdir -p bin out && gcc % -o bin/n && bin/n > out/n.txt")<CR>
endif
