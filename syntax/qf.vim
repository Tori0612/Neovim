if exists('b:current_syntax')
    finish
endif

syn match qfFileName /^[^|]*/ nextgroup=qfSeparatorLeft
syn match qfSeparatorLeft /|/ contained nextgroup=qfLineNr
syn match qfLineNr /[^|]*/ contained nextgroup=qfSeparatorRight
syn match qfSeparatorRight '|' contained nextgroup=qfError,qfWarning,qfInfo,qfNote
syn match qfError / E .*$/ contained
syn match qfWarning / W .*$/ contained
syn match qfInfo / I .*$/ contained
syn match qfNote / [NH] .*$/ contained

hi def link qfFileName FilePath
hi def link qfSeparatorLeft OkMsg
hi def link qfSeparatorRight OkMsg
hi def link qfLineNr NonText
hi def link qfError DiagnosticError
hi def link qfWarning DiagnosticWarn
hi def link qfInfo DiagnosticInfo
hi def link qfNote DiagnosticHint

let b:current_syntax = 'qf'
