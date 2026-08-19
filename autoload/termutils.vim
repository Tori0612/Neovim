" @p autoload/termutils.vim

function! termutils#Expand(cmd)
    let l:cmd = a:cmd
    let l:cmd = substitute(l:cmd, '%:p:h', shellescape(expand('%:p:h')), 'g')
    let l:cmd = substitute(l:cmd, '%:p:r', shellescape(expand('%:p:r')), 'g')
    let l:cmd = substitute(l:cmd, '%:p',   shellescape(expand('%:p')),   'g')
    let l:cmd = substitute(l:cmd, '%:t:r', shellescape(expand('%:t:r')), 'g')
    let l:cmd = substitute(l:cmd, '%:t',   shellescape(expand('%:t')),   'g')
    let l:cmd = substitute(l:cmd, '%:h', shellescape(expand('%:p:h')), 'g')
    let l:cmd = substitute(l:cmd, '%:r', shellescape(expand('%:p:r')), 'g')
    let l:cmd = substitute(l:cmd, '%', shellescape(expand('%:p')), 'g')
    let l:cmd = substitute(l:cmd, '\<n\>', shellescape(expand('%:t:r')), 'g')
    let l:cmd = substitute(l:cmd, '\<bin\>', shellescape(expand('%:p:h') . '/bin'), 'g')
    let l:cmd = substitute(l:cmd, '\<out\>', shellescape(expand('%:p:h') . '/out'), 'g')
    return l:cmd
endfunction

function! termutils#Run(cmd)
    call luaeval("require('custom.termtools').run_cmd(_A)", {'cmd': termutils#Expand(a:cmd), 'mode': 'hold'})
endfunction

