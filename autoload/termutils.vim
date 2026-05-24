" @p autoload/termutils.vim

function! termutils#Expand(cmd)
    let l:cmd = a:cmd
    let l:cmd = substitute(l:cmd, '%:r', shellescape(expand('%:p:r')), 'g')
    let l:cmd = substitute(l:cmd, '%', shellescape(expand('%:p')), 'g')
    return l:cmd
endfunction

function! termutils#Run(cmd)
    call luaeval("require('custom.termtools').run_cmd(_A)", {'cmd': termutils#Expand(a:cmd), 'mode': 'hold'})
endfunction

