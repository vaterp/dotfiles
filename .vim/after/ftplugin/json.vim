syntax region foldBraces start=/{/ end=/}/ transparent fold keepend extend
syntax region foldBraces start=/\[/ end=/\]/ transparent fold keepend extend

setlocal autoindent
setlocal formatoptions=tcq2l
setlocal expandtab
setlocal foldmethod=syntax
setlocal foldlevel=1 "could be 99 for everything open; 0 for everything closed

setlocal  textwidth=78 shiftwidth=2 softtabstop=2 tabstop=2
set list
set listchars=tab:▸\ ,eol:¬
"set listchars=eol:$,tab:|-,trail:~,extends:>,precedes:<
"autocmd BufWritePre <buffer> :%!python -mjson.tool
