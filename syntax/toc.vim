" syntax/toc.vim

if exists('b:current_syntax')
    finish
endif

syn match tocFileName /^[^|]*/ nextgroup=tocSep1
syn match tocSep1     /|/ contained nextgroup=tocLineNr conceal cchar=❘
syn match tocLineNr   /[^|]*/ contained nextgroup=tocLineSep2
syn match tocLineSep2 /|/ contained nextgroup=tocText conceal cchar=❘
syn match tocText     /.*$/ contained

hi def link tocFileName FilePath
hi def link tocSep1 Comment
hi def link tocLineNr Comment
hi def link tocLineSep2 LineNr
hi def link tocText Function

let b:current_syntax = 'toc'
