setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab

setlocal commentstring=//\ %s

setlocal makeprg=javac\ %

function! GenerateJavaMainBoilerplate()
    let l:class_name = expand('%:t:r')
    
    call setreg('c', l:class_name)

    let l:template = [
        \ 'public class ' . l:class_name . ' {',
        \ '    public static void main(String[] args) {',
        \ '        ',
        \ '    }',
        \ '}'
        \ ]
    call setline(2, l:template)
    call cursor(4, 9)
endfunction

function! GenerateJavaBoilerplate()
    let l:class_name = expand('%:t:r')
    
    call setreg('c', l:class_name)

    let l:template = [
        \ 'public class ' . l:class_name . ' {',
        \ '    ',
        \ '}'
        \ ]
    call setline(2, l:template)
    call cursor(3, 5)
endfunction

nnoremap <buffer> <leader>jbm :call GenerateJavaMainBoilerplate()<CR>
nnoremap <buffer> <leader>jbc :call GenerateJavaBoilerplate()<CR>
nnoremap <buffer> <leader>r :w<CR>:!javac % && java %:r<CR>
