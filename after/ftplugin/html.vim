" @p after/ftplugin/html.vim
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab

inoremap <buffer> </ </<C-x><C-o><Esc>F<

inoremap <buffer> > ><Esc>:call <SID>CloseTag()<CR>a
function! s:CloseTag()
    let line = getline('.')
    let col = col('.')
    if line[col-2] == '>'
        return
    endif
    let tag = matchstr(line[:col-2], '<\zs[^> ]*')
    if tag != '' && tag !~ 'br\|hr\|img\|input\|link\|meta\|area\|base\|col\|embed\|param'
        call setline('.', line[:col-1] . '</' . tag . '>' . line[col:])
    endif
endfunction
