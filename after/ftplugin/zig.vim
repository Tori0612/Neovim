if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1
setlocal shiftwidth=4
setlocal tabstop=4
setlocal noexpandtab
setlocal commentstring=//\ %s

setlocal makeprg=zig\ build

nnoremap <buffer> <leader>rr :w<CR>:!zig run %<CR>
nnoremap <buffer> <leader>r :w<CR>:make<CR>
