setlocal shiftwidth=4 tabstop=4 expandtab nowrap

let php_sql_query = 1
let php_baselib = 1
let php_htmlInStrings = 1
let php_noShortTags = 1
let php_parent_error_close = 1
let php_parent_error_open = 1
" let php_folding = 1
"let php_sync_method = x

" for QuickFix
setlocal errorformat=%m\ in\ %f\ on\ line\ %l

""
" PHP Lint
" nmap ,l :call PHPLint()<CR>

""
" PHPLint
"
" @author halt feits <halt.feits at gmail.com>
"
" function PHPLint()
"     let result = system( &ft . ' -l ' . bufname(""))
"     echo result
" endfunction
