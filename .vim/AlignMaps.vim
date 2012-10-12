" AlignMaps:   Alignment maps based upon <Align.vim>
" Maintainer:  Dr. Charles E. Campbell, Jr. <Charles.Campbell@gsfc.nasa.gov>
" Last Change: May 13, 2004
" Version:     28
" License:     GPL (Gnu Public License)
"
" NOTE: the code herein needs vim 6.0 or later
"       and needs <Align.vim> v6 or later
"
" Usage:
" Use 'a to mark beginning of to-be-aligned region,   Alternative:  use v
" move cursor to end of region, and execute map.      (visual mode) to mark
" The maps also set up marks 'y and 'z, and retain    region, execute same map.
" 'a at the beginning of region.                      Uses 'a, 'y, and 'z.
"
" Although the comments indicate the maps use a leading backslash,
" actually they use <Leader> (:he mapleader), so the user can
" specify that the maps start how he or she prefers.
"
" Note: these maps all use <Align.vim>.
" ---------------------------------------------------------------------

" Prevent duplicate loading
if exists("g:loaded_alignmaps") || &cp
 finish
endif
let g:loaded_alignmaps= 1

" ---------------------------------------------------------------------

" WS: wrapper start (internal)   Produces a blank line above and
"     below, marks with 'y and 'z
if !hasmapto('<Plug>WrapperStart')
 nmap <unique> \WS	<Plug>AlignMapsWrapperStart
endif
nmap <silent> <script> <Plug>AlignMapsWrapperStart	:set lz<CR>:call <SID>WrapperStart()<CR>

" WrapperStart:
fu! <SID>WrapperStart()
  let b:alignmaps_posn        = <SID>GetPosn()
  let b:alignmaps_keepsearch  = @/
  let b:alignmaps_keepmy      = <SID>GetMark("'y")
  let b:alignmaps_keepmz      = <SID>GetMark("'z")
  let b:alignmaps_keepgd      = &gdefault
  set nogd
  put =''
  norm! mz'a
  put! = ''
  let b:alignmaps_ch= &ch
  set ch=2
  norm! my
  exe "'y,'zs/@/\177/ge"
  call AlignPush()
  norm! 'zk
endfunction

" ---------------------------------------------------------------------

" WE: wrapper end (internal)   Removes guard lines,
"     restores marks y and z, and restores search pattern
if !hasmapto('<Plug>WrapperEnd')
 nmap <unique> \WE	<Plug>AlignMapsWrapperEnd
endif
nmap <silent> <script> <Plug>AlignMapsWrapperEnd	:call <SID>WrapperEnd()<CR>:set nolz<CR>

" WrapperEnd:
fun! <SID>WrapperEnd()
  'y,'zs/\s\+$//e
  exe "'y,'zs/\177/@/ge"
  norm! 'yjmakdd'zdd
  exe "set ch=".b:alignmaps_ch
  unlet b:alignmaps_ch
  let @/= b:alignmaps_keepsearch
  call AlignPop()

  " cleanup
  call <SID>PutMark(b:alignmaps_keepmy)
  call <SID>PutMark(b:alignmaps_keepmz)
  call <SID>PutPosn(b:alignmaps_posn)
  unlet b:alignmaps_keepmy  b:alignmaps_keepmz b:alignmaps_posn
  let &gd= b:alignmaps_keepgd
endfun

" ---------------------------------------------------------------------

" complex C-code alignment maps
map <silent> <Leader>a?    \WS:AlignCtrl mIp1P1lC ? : : : : <CR>:'a,.Align<CR>:'a,'z-1s/\(\s\+\)? /?\1/e<CR>\WE
map <silent> <Leader>a,    \WS:'y,'zs/\(\S\)\s\+/\1 /ge<CR>'yjma'zk<Leader>jnr,<CR>:silent 'y,'zg/,/let @x=substitute(getline(line(".")),'^\(.\{-}\) \S\+\s*,.*$','silent s/,/;\\r\1 /g','')<Bar>@x<CR>\WE
map <silent> <Leader>a<    \WS:AlignCtrl mIp1P1=l << >><CR>:'a,.Align<CR>\WE
map <silent> <Leader>abox  \WS:let b:alignmaps_iws=substitute(getline("'a"),'^\(\s*\).*$','\1','e')<CR>:'a,'z-1s/^\s\+//e<CR>:'a,'z-1s/^.*$/@&@/<CR>:AlignCtrl m=p01P0w @<CR>:'a,.Align<CR>:'a,'z-1s/@/ * /<CR>:'a,'z-1s/@$/*/<CR>'aYP:s/./*/g<CR>0r/'zkYp:s/./*/g<CR>0r A/<Esc>:exe "'a-1,'z-1s/^/".b:alignmaps_iws."/e"<CR>\WE
map <silent> <Leader>acom  \WS:'a,.s/\/[*/]/@&@/e<CR>:'a,.s/\*\//@&/e<CR>'zk<Leader>tW@:'y,'zs/^\(\s*\) @/\1/e<CR>:'y,'zs/ @//eg<CR>\WE
map <silent> <Leader>ascom \WS:'a,.s/\/[*/]/@&@/e<CR>:'a,.s/\*\//@&/e<CR>:silent! 'a,.g/^\s*@\/[*/]/s/@//ge<CR>:AlignCtrl v ^\s*\/[*/]<CR>:AlignCtrl g \/[*/]<CR>'zk<Leader>tW@:'y,'zs/^\(\s*\) @/\1/e<CR>:'y,'zs/ @//eg<CR>\WE
map <silent> <Leader>adec  \WS:'a,'zs/\([^ \t/(]\)\([*&]\)/\1 \2/e<CR>:'y,'zv/^\//s/\([^ \t]\)\s\+/\1 /ge<CR>:'y,'zv/^\s*[*/]/s/\([^/][*&]\)\s\+/\1/ge<CR>:'y,'zv/^\s*[*/]/s/^\(\s*\%(\h\w*\s\+\%([a-zA-Z_*(&]\)\@=\)\+\)\([*(&]*\)\s*\([a-zA-Z0-9_()]\+\)\s*\(\(\[.\{-}]\)*\)\s*\(=\)\=\s*\(.\{-}\)\=\s*;/\1@\2#@\3\4@\6@\7;@/e<CR>:'y,'zv/^\s*[*/]/s/\*\/\s*$/@*\//e<CR>:'y,'zv/^\s*[*/]/s/^\s\+\*/@@@@@* /e<CR>:'y,'zv/^\s*[*/]/s/^@@@@@\*\(.*[^*/]\)$/&@*/e<CR>'yjma'zk:AlignCtrl v ^\s*[*/#]<CR><Leader>t@:'y,'zv/^\s*[*/]/s/@ //ge<CR>:'y,'zv/^\s*[*/]/s/\(\s*\);/;\1/e<CR>:'y,'zv/^#/s/# //e<CR>:'y,'zv/^\s\+[*/#]/s/\([^/*]\)\(\*\+\)\( \+\)/\1\3\2/e<CR>:'y,'zv/^\s\+[*/#]/s/\((\+\)\( \+\)\*/\2\1*/e<CR>:'y,'zv/^\s\+[*/#]/s/^\(\s\+\) \*/\1*/e<CR>:'y,'zv/^\s\+[*/#]/s/[ \t@]*$//e<CR>:'y,'zs/^[*]/ */e<CR>\WE
map <silent> <Leader>adef  \WS:AlignPush<CR>:AlignCtrl v ^\s*\(\/\*\<bar>\/\/\)<CR>:'a,.v/^\s*\(\/\*\<bar>\/\/\)/s/^\(\s*\)#\(\s\)*define\s*\(\I[a-zA-Z_0-9(),]*\)\s*\(.\{-}\)\($\<Bar>\/\*\)/#\1\2define @\3@\4@\5/e<CR>:'a,.v/^\s*\(\/\*\<bar>\/\/\)/s/\($\<Bar>\*\/\)/@&/e<CR>'zk<Leader>t@'yjma'zk:'a,.v/^\s*\(\/\*\<bar>\/\/\)/s/ @//g<CR>\WE
map <silent> <Leader>afnc  :set lz<CR>:silent call <SID>Afnc()<CR>:set nolz<CR>
map <silent> <Leader>anum  \WS:'a,'zs/\(\d\)\s\+\(-\=[.,]\=\d\)/\1@\2/ge<CR>:AlignCtrl mp0P0<CR>:'a,'zAlign [.,@]<CR>:'a,'zs/\([-0-9.,]*\)\(\s*\)\([.,]\)/\2\1\3/g<CR>:'a,'zs/@/ /ge<CR>\WE

" html table alignment
map <silent> <Leader>Htd \WS:'y,'zs%<[tT][rR]><[tT][dD][^>]\{-}>\<Bar></[tT][dD]><[tT][dD][^>]\{-}>\<Bar></[tT][dD]></[tT][rR]>%@&@%g<CR>'yjma'zk:AlignCtrl m=Ilp1P0 @<CR>:'a,.Align<CR>:'y,'zs/ @/@/<CR>:'y,'zs/@ <[tT][rR]>/<[tT][rR]>/ge<CR>:'y,'zs/@//ge<CR>\WE

" character-based right-justified alignment maps
map <silent> <Leader>T| \WS:AlignCtrl mIp0P0=r <Bar><CR>:'a,.Align<CR>\WE
map <silent> <Leader>T#   \WS:AlignCtrl mIp0P0=r #<CR>:'a,.Align<CR>\WE
map <silent> <Leader>T,   \WS:AlignCtrl mIp0P1=r ,<CR>:'a,.Align<CR>\WE
map <silent> <Leader>Ts,  \WS:AlignCtrl mIp0P1=r ,<CR>:'a,.Align<CR>:'a,.s/\(\s*\),/,\1/ge<CR>\WE
map <silent> <Leader>T:   \WS:AlignCtrl mIp1P1=r :<CR>:'a,.Align<CR>\WE
map <silent> <Leader>T;   \WS:AlignCtrl mIp0P0=r ;<CR>:'a,.Align<CR>\WE
map <silent> <Leader>T<   \WS:AlignCtrl mIp0P0=r <<CR>:'a,.Align<CR>\WE
map <silent> <Leader>T=   \WS:'a,'z-1s/\s\+\([*/+\-%<Bar>&\~^]\==\)/ \1/e<CR>:'a,'z-1s@ \+\([*/+\-%<Bar>&\~^]\)=@\1=@ge<CR>:'a,'z-1s/; */;@/e<CR>:'a,'z-1s/==/``/ge<CR>:'a,'z-1s/!=/!`/ge<CR>:AlignCtrl mIp1P1=r = @<CR>:AlignCtrl g =<CR>:'a,'z-1Align<CR>:'a,'z-1s/; *@/;/e<CR>:'a,'z-1s/; *$/;/e<CR>:'a,'z-1s@\([*/+\-%<Bar>&\~^]\)\( \+\)=@\2\1=@ge<CR>:'a,'z-1s/\( \+\);/;\1/ge<CR>:'a,'z-1s/`/=/ge<CR>\WE<Leader>acom
map <silent> <Leader>T?   \WS:AlignCtrl mIp0P0=r ?<CR>:'a,.Align<CR>:'y,'zs/ \( *\);/;\1/ge<CR>\WE
map <silent> <Leader>T@   \WS:AlignCtrl mIp0P0=r @<CR>:'a,.Align<CR>\WE
map <silent> <Leader>Tab  \WS:'a,.s/^\(\t*\)\(.*\)/\=submatch(1).escape(substitute(submatch(2),'\t','@','g'),'\')/<CR>:AlignCtrl mI=r @<CR>:'a,.Align<CR>:'y+1,'z-1s/@/ /g<CR>\WE
map <silent> <Leader>Tsp  \WS:'a,.s/^\(\s*\)\(.*\)/\=submatch(1).escape(substitute(submatch(2),'\s\+','@','g'),'\')/<CR>:AlignCtrl mI=r @<CR>:'a,.Align<CR>:'y+1,'z-1s/@/ /g<CR>\WE
map <silent> <Leader>T~   \WS:AlignCtrl mIp0P0=r ~<CR>:'a,.Align<CR>:'y,'zs/ \( *\);/;\1/ge<CR>\WE

" character-based left-justified alignment maps
map <silent> <Leader>t| \WS:AlignCtrl mIp0P0=l <Bar><CR>:'a,.Align<CR>\WE
map <silent> <Leader>t#   \WS:AlignCtrl mIp0P0=l #<CR>:'a,.Align<CR>\WE
map <silent> <Leader>t,   \WS:AlignCtrl mIp0P1=l ,<CR>:'a,.Align<CR>\WE
map <silent> <Leader>ts,  \WS:AlignCtrl mIp0P0=l ,<CR>:'a,.Align<CR>:'a,.s/\(\s*\),/,\1/ge<CR>\WE
map <silent> <Leader>t:   \WS:AlignCtrl mIp1P1=l :<CR>:'a,.Align<CR>\WE
map <silent> <Leader>t;   \WS:AlignCtrl mIp0P0=l ;<CR>:'a,.Align<CR>:.,'zs/ \( *\);/;\1/ge<CR>\WE
map <silent> <Leader>t<   \WS:AlignCtrl mIp0P0=l <<CR>:'a,.Align<CR>\WE

map <silent> <Leader>t=   \WS:'a,'zs/\s\+\([*/+\-%<Bar>&\~^]\==\)/ \1/e<CR>:'a,'zs@ \+\([*/+\-%<Bar>&\~^]\)=@\1=@ge<CR>:'a,'zs/==/``/ge<CR>:'a,'zs/!=/!`/ge<CR>'zk:AlignCtrl mIp1P1=l =<CR>:AlignCtrl g =<CR>:'a,'z-1Align<CR>:'a,'z-1s@\([*/+\-%<Bar>&\~^!=]\)\( \+\)=@\2\1=@ge<CR>:'a,'z-1s/\( \+\);/;\1/ge<CR>:'a,'z-1v/^\s*\/[*/]/s/\/[*/]/@&@/e<CR>:'a,'z-1v/^\s*\/[*/]/s/\*\//@&/e<CR>'zk<Leader>t@:'y,'zs/^\(\s*\) @/\1/e<CR>:'a,'z-1s/`/=/ge<CR>:'y,'zs/ @//eg<CR>\WE
map <silent> <Leader>t?   \WS:AlignCtrl mIp0P0=l ?<CR>:'a,.Align<CR>:.,'zs/ \( *\);/;\1/ge<CR>\WE
map <silent> <Leader>tab  \WS:'a,.s/^\(\t*\)\(.*\)/\=submatch(1).escape(substitute(submatch(2),'\t','@','g'),'\')/<CR>:AlignCtrl mI=l @<CR>:'a,.Align<CR>:'y+1,'z-1s/@/ /g<CR>\WE
map <silent> <Leader>tsp  \WS:'a,.s/^\(\s*\)\(.*\)/\=submatch(1).escape(substitute(submatch(2),'\s\+','@','g'),'\')/<CR>:AlignCtrl mI=l @<CR>:'a,.Align<CR>:'y+1,'z-1s/@/ /g<CR>\WE
map <silent> <Leader>tsq  \WS:'a,.ReplaceQuotedSpaces<CR>:'a,.s/^\(\s*\)\(.*\)/\=submatch(1).substitute(submatch(2),'\s\+','@','g')/<CR>:AlignCtrl mIp0P0=l @<CR>:'a,.Align<CR>:'y+1,'z-1s/[%@]/ /g<CR>\WE
map <silent> <Leader>tt   \WS:AlignCtrl mIp1P1=l \\\@<!& \\\\<CR>:'a,.Align<CR>\WE
map <silent> <Leader>t~   \WS:AlignCtrl mIp0P0=l ~<CR>:'a,.Align<CR>:'y,'zs/ \( *\);/;\1/ge<CR>\WE

" plain Align maps; these two are used in <Leader>acom..\afnc
map <silent> <Leader>t@   :AlignCtrl mIp1P1=l @<CR>:'a,.Align<CR>
map <silent> <Leader>tW@  :AlignCtrl mWp1P1=l @<CR>:'a,.Align<CR>

" Joiner
map <silent> <Leader>jnr=  :call <SID>CharJoiner("=")<CR>
map <silent> <Leader>jnr,  :call <SID>CharJoiner(",")<CR>

" visual-line mode variants
vmap <silent> <Leader>T|	:<BS><BS><BS><CR>ma'><Leader>T|
vmap <silent> <Leader>T,	:<BS><BS><BS><CR>ma'><Leader>T,
vmap <silent> <Leader>Ts,	:<BS><BS><BS><CR>ma'><Leader>Ts,
vmap <silent> <Leader>T:	:<BS><BS><BS><CR>ma'><Leader>T:
vmap <silent> <Leader>T<	:<BS><BS><BS><CR>ma'><Leader>T<
vmap <silent> <Leader>T=	:<BS><BS><BS><CR>ma'><Leader>T=
vmap <silent> <Leader>T@	:<BS><BS><BS><CR>ma'><Leader>T@
vmap <silent> <Leader>Tsp	:<BS><BS><BS><CR>ma'><Leader>Tsp
vmap <silent> <Leader>a?	:<BS><BS><BS><CR>ma'><Leader>a?
vmap <silent> <Leader>a,	:<BS><BS><BS><CR>ma'><Leader>a,
vmap <silent> <Leader>abox	:<BS><BS><BS><CR>ma'><Leader>abox
vmap <silent> <Leader>acom	:<BS><BS><BS><CR>ma'><Leader>acom
vmap <silent> <Leader>ascom	:<BS><BS><BS><CR>ma'><Leader>ascom
vmap <silent> <Leader>adec	:<BS><BS><BS><CR>ma'><Leader>adec
vmap <silent> <Leader>adef	:<BS><BS><BS><CR>ma'><Leader>adef
vmap <silent> <Leader>afnc	:<BS><BS><BS><CR>ma'><Leader>afnc
vmap <silent> <Leader>anum	:<BS><BS><BS><CR>ma'><Leader>anum
vmap <silent> <Leader>t|	:<BS><BS><BS><CR>ma'><Leader>t|
vmap <silent> <Leader>t,	:<BS><BS><BS><CR>ma'><Leader>t,
vmap <silent> <Leader>ts,	:<BS><BS><BS><CR>ma'><Leader>ts,
vmap <silent> <Leader>t:	:<BS><BS><BS><CR>ma'><Leader>t:
vmap <silent> <Leader>t;	:<BS><BS><BS><CR>ma'><Leader>t;
vmap <silent> <Leader>t<	:<BS><BS><BS><CR>ma'><Leader>t<
vmap <silent> <Leader>t=	:<BS><BS><BS><CR>ma'><Leader>t=
vmap <silent> <Leader>t?	:<BS><BS><BS><CR>ma'><Leader>t?
vmap <silent> <Leader>t@	:<BS><BS><BS><CR>ma'><Leader>t@
vmap <silent> <Leader>tab	:<BS><BS><BS><CR>ma'><Leader>tab
vmap <silent> <Leader>tsp	:<BS><BS><BS><CR>ma'><Leader>tsp
vmap <silent> <Leader>tsq	:<BS><BS><BS><CR>ma'><Leader>tsq
vmap <silent> <Leader>tp@	:<BS><BS><BS><CR>ma'><Leader>tp@
vmap <silent> <Leader>tt	:<BS><BS><BS><CR>ma'><Leader>tt
vmap <silent> <Leader>Htd	:<BS><BS><BS><CR>ma'><Leader>Htd
vmap <silent> <Leader>anum  :B s/\(\d\)\s\+\(-\=[.,]\=\d\)/\1@\2/ge<CR>:AlignCtrl mp0P0<CR>gv:Align [.,@]<CR>:'<,'>s/\([-0-9.,]*\)\(\s\+\)\([.,]\)/\2\1\3/ge<CR>:'<,'>s/@/ /ge<CR>

" ---------------------------------------------------------------------

" CharJoiner: joins lines which end in the given character (spaces
"             at end are ignored)
fun! <SID>CharJoiner(chr)
  let aline = line("'a")
  let rep   = line(".") - aline
  while rep > 0
  	norm! 'a
  	while match(getline(aline),a:chr . "\s*$") != -1 && rep >= 0
  	  " while = at end-of-line, delete it and join with next
  	  norm! 'a$
  	  j!
  	  let rep = rep - 1
  	endwhile
  	" update rep(eat) count
  	let rep = rep - 1
  	if rep <= 0
  	  " terminate loop if at end-of-block
  	  break
  	endif
  	" prepare for next line
  	norm! jma
  	let aline = line("'a")
  endwhile
endfun

" ---------------------------------------------------------------------

" Afnc: useful for splitting one-line function beginnings
"            into one line per argument format
fu! <SID>Afnc()
  " keep display quiet
  let chkeep = &ch
  let gdkeep = &gd
  let vekeep = &ve
  set ch=2 nogd ve=

  " will use marks y,z ; save current values
  let mykeep = s:GetMark("'y")
  let mzkeep = s:GetMark("'z")

  " Find beginning of function -- be careful to skip over comments
  let cmmntid  = synIDtrans(hlID("Comment"))
  let stringid = synIDtrans(hlID("String"))
  exe "norm! ]]"
  while search(")","bW") != 0
"   call Decho("line=".line(".")." col=".col("."))
   let parenid= synIDtrans(synID(line("."),col("."),1))
   if parenid != cmmntid && parenid != stringid
   	break
   endif
  endwhile
  norm! %my
  s/(\s*\(\S\)/(\r  \1/e
  exe "norm! `y%"
  s/)\s*\(\/[*/]\)/)\r\1/e
  exe "norm! `y%mz"
  'y,'zs/\s\+$//e
  'y,'zs/^\s\+//e
  'y+1,'zs/^/  /

  " insert newline after every comma only one parenthesis deep
  sil! exe "norm! `y\<right>h"
  let parens   = 1
  let cmmnt    = 0
  let cmmntline= -1
  while parens >= 1
"   call Decho("parens=".parens." @a=".@a)
   exe 'norm! ma "ay`a '
   if @a == "("
    let parens= parens + 1
   elseif @a == ")"
    let parens= parens - 1

   " comment bypass:  /* ... */  or //...
   elseif cmmnt == 0 && @a == '/'
    let cmmnt= 1
   elseif cmmnt == 1
	if @a == '/'
	 let cmmnt    = 2   " //...
	 let cmmntline= line(".")
	elseif @a == '*'
	 let cmmnt= 3   " /*...
	else
	 let cmmnt= 0
	endif
   elseif cmmnt == 2 && line(".") != cmmntline
	let cmmnt    = 0
	let cmmntline= -1
   elseif cmmnt == 3 && @a == '*'
	let cmmnt= 4
   elseif cmmnt == 4
	if @a == '/'
	 let cmmnt= 0   " ...*/
	elseif @a != '*'
	 let cmmnt= 3
	endif

   elseif @a == "," && parens == 1 && cmmnt == 0
	exe "norm! i\<CR>\<Esc>"
   endif
  endwhile
  norm! `y%mz%
  sil! 'y,'zg/^\s*$/d

  " perform substitutes to mark fields for Align
  sil! 'y+1,'zv/^\//s/^\s\+\(\S\)/  \1/e
  sil! 'y+1,'zv/^\//s/\(\S\)\s\+/\1 /eg
  sil! 'y+1,'zv/^\//s/\* \+/*/ge
  "                                                 func
  "                    ws  <- declaration   ->    <-ptr  ->   <-var->    <-[array][]    ->   <-glop->      <-end->
  sil! 'y+1,'zv/^\//s/^\s*\(\(\w\+\s*\)\+\)\s\+\([(*]*\)\s*\(\w\+\)\s*\(\(\[.\{-}]\)*\)\s*\(.\{-}\)\=\s*\([,)]\)\s*$/  \1@#\3@\4\5@\7\8/e
  sil! 'y+1,'z+1g/^\s*\/[*/]/norm! kJ
  sil! 'y+1,'z+1s%/[*/]%@&@%ge
  sil! 'y+1,'z+1s%*/%@&%ge
  AlignCtrl mIp0P0=l @
  sil! 'y+1,'zAlign
  sil! 'y,'zs%@\(/[*/]\)@%\t\1 %e
  sil! 'y,'zs%@\*/% */%e
  sil! 'y,'zs/@\([,)]\)/\1/
  sil! 'y,'zs/@/ /
  AlignCtrl mIlrp0P0= # @
  sil! 'y+1,'zAlign
  sil! 'y+1,'zs/#/ /
  sil! 'y+1,'zs/@//
  sil! 'y+1,'zs/\(\s\+\)\([,)]\)/\2\1/e

  " Restore
  call s:PutMark(mykeep)
  call s:PutMark(mzkeep)
  let &ch= chkeep
  let &gd= gdkeep
  let &ve= vekeep
endfunction

" ---------------------------------------------------------------------

" GetPosn: gets a string describing current position
fu! s:GetPosn()
  let curline = line(".")
  let curcol  = virtcol(".")
  norm! H
  let curhline= line(".")
  exe "norm! ".curhline."G0z\<CR>".curline.'G'.curcol.'|'
  return curhline.":".curline.".".curcol
endfunction

" ---------------------------------------------------------------------

fu! s:PutPosn(posnvar)
  let gotohline = substitute(a:posnvar,'^\(\d\+\):\(\d\+\)\.\(\d\+\)','\1','')
  let gotoline  = substitute(a:posnvar,'^\(\d\+\):\(\d\+\)\.\(\d\+\)','\2','')
  let gotocol   = substitute(a:posnvar,'^\(\d\+\):\(\d\+\)\.\(\d\+\)','\3','')
  exe "norm! ".gotohline."G0z\<CR>".gotoline.'G'.gotocol.'|'
endfunction

" ---------------------------------------------------------------------

" GetMark: gets a string describing the mark
fu! s:GetMark(markname)
  return strpart(a:markname,1,1).':'.line(a:markname).'.'.virtcol(a:markname)
endfunction

" ---------------------------------------------------------------------

" PutMark: puts a mark back based on the string describing it
fu! s:PutMark(markvar)
  let markname= substitute(a:markvar,'^\(.*\)\(:.*\)\(\..*\)$','\1','')
  let markline= substitute(a:markvar,'^\(.*:\)\(.*\)\(\..*\)$','\2','')
  let markcol = substitute(a:markvar,'^\(.*:\)\(.*\.\)\(.*\)$','\3','')
  if markline != 0 || markcol != 0
   let curline = line(".")
   let curcol  = virtcol(".")
   exe "norm! ".markline.'G'.markcol.'|m'.markname
   exe "norm! ".curline.'G'.curcol.'|'
  endif
endfunction

" ---------------------------------------------------------------------

" vim: ts=4 nowrap
