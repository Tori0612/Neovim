" @p after/ftplugin/python.vim
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab

setlocal makeprg=python3\ %
setlocal errorformat=%ETraceback%.%#,%Z%f:%l:\ %m

xnoremap <buffer> af :<C-u>call search('^\\s*\\(def\\|class\\)\\>', 'bW')<CR>V:<C-u>call search('^\\s*$', 'W')<CR>
onoremap <buffer> af :<C-u>call search('^\\s*\\(def\\|class\\)\\>', 'bW')<CR>V:<C-u>call search('^\\s*$', 'W')<CR>

autocmd BufWritePre <buffer> silent! lua if vim.lsp.get_clients({bufnr=0})[1] then vim.lsp.buf.format({async=false}) end

noremap <buffer> <leader>rr :call termutils#Run("python3 %")<CR>
noremap <buffer> <leader>rt :call termutils#Run("python3 -m pytest %")<CR>
noremap <buffer> <leader>ri :call termutils#Run("python3 -i %")<CR>
noremap <buffer> <leader>rm :Manim<CR>
noremap <buffer> <leader>rw :ManimWatch<CR>
noremap <buffer> <leader>rs :ManimStop<CR>

setlocal foldmethod=indent
setlocal foldnestmax=2

setlocal commentstring=#\ %s
