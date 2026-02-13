" after/ftplugin/python.vim
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab
setlocal textwidth=88
setlocal colorcolumn=89

setlocal makeprg=python3\ %
setlocal errorformat=%ETraceback%.%#,%Z%f:%l:\ %m

xnoremap <buffer> af :<C-u>call search('^\\s*\\(def\\|class\\)\\>', 'bW')<CR>V:<C-u>call search('^\\s*$', 'W')<CR>
onoremap <buffer> af :<C-u>call search('^\\s*\\(def\\|class\\)\\>', 'bW')<CR>V:<C-u>call search('^\\s*$', 'W')<CR>

autocmd BufWritePre <buffer> silent! lua if vim.lsp.get_clients({bufnr=0})[1] then vim.lsp.buf.format({async=false}) end

noremap <buffer> <leader>rr :!python3 %<CR>
noremap <buffer> <leader>rt :!python3 -m pytest %<CR>
noremap <buffer> <leader>ri :!python3 -i %<CR>

setlocal foldmethod=indent
setlocal foldnestmax=2

setlocal commentstring=#\ %s
