setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab

noremap <buffer> <leader>rr :!node %<CR>
noremap <buffer> <leader>rt :!node test %<CR>
noremap <buffer> <leader>rd :!node --inspect-brk %<CR>

noremap <buffer> <leader>cl yiwoconsole.log('<C-r>":', <C-r>");<Esc>
noremap <buffer> <leader>cl yoconsole.log('<C-r>":', <C-r>");<Esc>

setlocal commentstring={/*\ %s\ */}
