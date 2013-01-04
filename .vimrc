" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible


set backspace=indent,eol,start		" allow backspacing over everything in insert mode
set autoindent			" always set autoindenting on
set backup		" keep a backup file
set background=dark
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set incsearch		" do incremental searching
set autowrite   " Auto write files on buffer moves & makes
set number
set hidden "Let me move around if buffers aren't saved

set nowrap "I seem to be preferring this recently
	"Set Cursorline Options I like
	"set cursorline  This would turn it on for ALL buffers
	"Not sure if i like this or not, but it makes the highlight much more obvious
	"hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
	augroup CursorLine
		au!
		au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
		au WinLeave * setlocal nocursorline
	augroup END
"End Set cursorline options

"C indention stuff... See help 'cinoptions-values'
set smartindent
set tabstop=2
set shiftwidth=2
set cino+=(0             "Align paramater lists after newline under '('
set cino+=e-1s           "No indent if '{' is not on its own line

set formatoptions-=r "Stop auto commenting on new lines
set formatoptions-=o "Stop auto commenting on Oo
if &t_Co > 2
  set hlsearch
  syntax on
endif

" Don't use Ex mode, use Q for formatting
map Q gq

"I like this search highlighting more then default
highlight IncSearch ctermfg=red
highlight Search ctermfg=red ctermbg=white

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc

" Switch syntax highlighting on, when the terminal has colors Also switch on
" highlighting the last used search pattern.
if has("gui_running")
"  highlight Type      ctermfg=green
"  highlight Statement ctermfg=1
"  highlight 
  set hlsearch
  syntax on
  hi Search guibg=LightBlue
	set background=light
	set guioptions-=T "get rid of toolbar
	set guioptions-=m "get rid of menu
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

	autocmd! bufwritepost .vimrc source ~/.vimrc

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal tw=78
	autocmd FileType text silent %s///ge
	autocmd FileType c,cpp set formatoptions-=ro


	autocmd BufRead,BufNewFile todo.txt set nobackup filetype=txt nowrap
	autocmd BufRead,BufNewFile vimhelp.txt set nobackup filetype=txt nowrap
	autocmd BufRead,BufNewFile putty*   set filetype=text
	autocmd BufRead,BufNewFile typescript*   set filetype=text


	"Automatically open compiler output window across bottom of vim, if errors.
	autocmd QuickFixCmdPost * botright cwindow 5



  " When editing a file, always jump to the last known cursor position.
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")

" Puttin' in my own stuff and gettin' fancy....
nnoremap <CR> :nohlsearch<CR>/<BS><CR>
map <F1> :SearchReset<CR>
"imap <F1> <ESC>:set hlsearch!<CR>a
set showmatch
set matchtime=3
"noremap % v%
if has("unix")
	map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
else
	map ,e :e <C-R>=expand("%:p:h") . "\\" <CR>
endif

set shortmess=a
set cmdheight=1
set title
 
"func! HideAll()
	"syn region myFold start="{" end="}" transparent fold
	"syn sync fromstart
	"set foldnestmax=2
	"set foldmethod=syntax
"endfunc

map <F9> call HideAll()

autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

fun! ScrollOtherWindow(dir)
	if a:dir == "down"
		let move = "\<C-D>"
	elseif a:dir == "up"
		let move = "\<C-U>"
	endif
	exec "normal \<C-W>p" . move . "\<C-W>p"
endfun 
nmap <silent> <M-Down> :call ScrollOtherWindow("down")<CR>
nmap <silent> <M-Up> :call ScrollOtherWindow("up")<CR>
autocmd FileType make setlocal noexpandtab
"For C code set iskeyword to -
"
"
"Buffer Navigation:
" ":e <filename>" to make a buffer with that file in it (duh)
" ",s" and ",f" for back and forth on the buffer list
" " ",b" for a list of what's in each buffer
" " ",1", ",2", .. ",9", ",0" to go straight to that numbered buffer (0 = 10)
" " ",g" to toggle between two buffers (my most used probably)
map ,p :bN<CR>
map ,n :bn<CR>
map ,H :call HideMe("PREV")<CR>
map ,h :call HideMe("NEXT")<CR>
map ,b :buffers<CR>
map ,g :e#<CR>
map ,1 :1b<CR>
map ,2 :2b<CR>
map ,3 :3b<CR>
map ,4 :4b<CR>
map ,5 :5b<CR>
map ,6 :6b<CR>
map ,7 :7b<CR>
map ,8 :8b<CR>
map ,9 :9b<CR>
map ,0 :10b<CR
set wildignore=*.o,*~,*.a,*.d

"Compile shortcuts...
nmap <F2> :ccl <CR>
nmap <F3> :cp <CR>
nmap <F4> :cn <CR>

nmap <F5> :ls<cr>:b! #<space>
nmap <S-F5> :ls!<cr>:b!<space> 

vnoremap ;; :%s:::g<Left><Left><Left>
vnoremap ;' :%s:::cg<Left><Left><Left><Left>

"Visual block search
vnoremap <silent> g/     y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vnoremap <silent> g?     y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

set tags=tags;/home/bsnyder/work
"set tags=$id/tags
" Nice way of auto centering the current line as i move around.
"set scrolloff=99999      

nmap ,x :source ~/.vimrc<CR>
nmap ,v :e ~/.vimrc<CR>
nmap ,z :e ~/.zshrc<CR>
nnoremap p p=`]
map <silent> <C-s> :if expand ("%") == ""<CR>: browse confirm w<CR>:else<CR>:confirm w<CR>:endif<CR>
imap <C-s> <C-o><C-s>

" Setup auto-comment
"

"Easy commenting by filemode....
autocmd FileType ahk                        let b:comment_leader = ';'
autocmd FileType vim                        let b:comment_leader = '"'
autocmd FileType c,cpp,java                 let b:comment_leader = '// '
autocmd FileType sh,make,perl,gdb           let b:comment_leader = '# '
noremap <silent> ,c :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> ,u :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>

runtime ftplugin/man.vim  "Gives :Man command

nnoremap <C-]> <Esc>:exe "ptjump " . expand("<cword>")<Esc>


"StatusLine settings
set laststatus=2 "Always show
"set statusline=%<\ %n:%f\ %m%r%y%=%-35. (line: \ %1\ of \ %L,\ col:\ %c%V\ (%P)%)
"set statusline=%n:%f\ %m%r%y%=%-35. (line: \ %1\ of \ %L,\ col:\ %c%V\ (%P)%)
"set statusline=%n:%F%m%r%h%w\%=[L:\%l\ C:\%c\ A:\%b\ H:\x%B\ P:\%p%%]
set statusline=%F\ %m\ %r%h%w\%=\%n\ [\%l,\%c\ \%p%%]
 
fun! HideMe(window)
	let ecmd = ""
	if a:window == "PREV"
     if bufnr("#") == -1
		    let ecmd = "e #"
	   endif
 endif
 if ecmd == ""
	 let ecmd = "bNext"
 endif
	exec ecmd
	exec "bwipeout". " #"
endfun
"cab     h    call HideMe()
"cab     hide call HideMe()

"Select from buffers matching a certain pattern
function! BufSel(pattern)
	let bufcount = bufnr("$")
	let currbufnr = 1
	let theonlybuf = 0

	"flag to determine if matches are found
	let foundmatch = 0
	while currbufnr <= bufcount
		if(bufexists(currbufnr))
			let currbufname = bufname(currbufnr)
			if(match(currbufname, a:pattern) > -1)
				echo currbufnr . ":    ". bufname(currbufnr)
				let foundmatch = foundmatch + 1
				let theonlybuf = currbufnr
			endif
		endif
		let currbufnr = currbufnr + 1
	endwhile

	if(foundmatch > 0)
		if (foundmatch == 1)
			exe ":bu ". theonlybuf
			return
	  endif
		let desiredbufnr = input("Enter buffer number: ")
		if(strlen(desiredbufnr) != 0)
			exe ":bu ".  desiredbufnr
		endif
	else
		echo "No matching buffers"
	endif
endfunction 
command! -nargs=1 BS call BufSel("<args>")
cab bs BS


cab man Man
cab vtag vertical stag

vnoremap * y/\V<C-R>=substitute(escape(@@,"/\\"),"\n","\\\\n","ge")<CR><CR> 
vnoremap # y?\V<C-R>=substitute(escape(@@,"?\\"),"\n","\\\\n","ge")<CR><CR>

function! Find(name) 
  let l:list=system("find . -name '".a:name."' | perl -ne 'print \"$.\\t$_\"'") 
  let l:num=strlen(substitute(l:list, "[^\n]", "", "g")) 
  if l:num < 1 
    echo "'".a:name."' not found" 
    return 
  endif 

  if l:num != 1 
    echo l:list 
    let l:input=input("Which ? (CR=nothing)\n") 

    if strlen(l:input)==0 
      return 
    endif 

    if strlen(substitute(l:input, "[0-9]", "", "g"))>0 
      echo "Not a number" 
      return 
    endif 

    if l:input<1 || l:input>l:num 
      echo "Out of range" 
      return 
    endif 

    let l:line=matchstr("\n".l:list, "\n".l:input."\t[^\n]*") 
  else 
    let l:line=l:list 
  endif 

  let l:line=substitute(l:line, "^[^\t]*\t./", "", "") 
  execute ":e ".l:line 
endfunction 
command! -nargs=1 Find :call Find("<args>")

fun! ShowFuncName() 
	let lnum = line(".") 
	let col = col(".") 
	echohl ModeMsg 
	echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW')) 
	echohl None 
	call search("\\%" . lnum . "l" . "\\%" . col . "c") 
endfun 
map ,f :call ShowFuncName() <CR> 


" New Stuff since rhub was made

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
	let isfirst = 1
	let words = []
	for word in split(a:cmdline)
		if isfirst
			let isfirst = 0  " don't change first word (shell command)
		else
			if word[0] =~ '\v[%#<]'
				let word = expand(word)
			endif
			let word = shellescape(word, 1)
		endif
		call add(words, word)
	endfor
	let expanded_cmdline = join(words)
	botright new
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
	call setline(1, 'You entered:  ' . a:cmdline)
	call setline(2, 'Expanded to:  ' . expanded_cmdline)
	call append(line('$'), substitute(getline(2), '.', '=', 'g'))
	silent execute '$read !'. expanded_cmdline
	1
endfunction


" Search for selected text, forwards or backwards
vnoremap <silent> * :<C-U>
			\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
			\gvy/<C-R><C-R>=substitute(
   \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
   \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
   \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>


"Multiple Search helpers
"Help cleaning up routr files
fun! DoSearchRouter()
 SearchBuffers uprtrASR1k#
 SearchBuffers uprtrASR1k(config)#
 SearchBuffers uprtrASR1k(config-.*)#
endfun
let @a='/h2xh'

"Some git help
map <silent> <f7> :call GITLOG_ToggleWindows()<CR>

"DCL STUFF
"autocmd BufReadPost ipstrc.* call DoIpsCleanup()
"autocmd BufRead,BufNewFile *.drw  set nowrap
"autocmd BufRead,BufNewFile *.dmp  set nowrap
"autocmd BufRead,BufNewFile *.log  set nowrap
"
"fun! DoIpsCleanup()
"	let currbufname = bufname("")
"	if(match(currbufname, "ipstrc.dmp") > -1)
"		echo "Doing dmp file reduction"
"		g/ips_hdr/d
"		g/\.\.\.\./d
"		g/Timestamp/d
"		g/Correlator/d
"		g/timer/d
"		g/Buffer addr    :/d
"		g/Queue ID       :/d
"		g/Sending process:/d
"		g/Process type   :/d
"		g/Location index :/d
"		g/Rcving process :/d
"		g/pkt_hdr\.data/d
"		g/appl_sock_handle/d
"		g/stub_sock_handle/d
"		g/return_pid/d
"		g/return_qid/d
"		g/msg_flags/d
"		g/end_of_data/d
"	endif
"	if (match(currbufname,"ipstrc.drw") > -1)
"		echo "Doing drw file reduction"
"		g/NBASE_ROOT/d
"		v/\$/d
"		g/timer/d
"		g/-----/d
"		g/NBB_POSTED_BUFFER/d
"		g/ATG_SCK_DATA/d
"		g/AMB_GET/d
"	endif
"endfun
"End DCL Stuff


"Json support

"au! BufRead,BufNewFile *.json set filetype=json
"
"augroup json_autocmd
"	autocmd!
"	autocmd FileType json set autoindent
"	autocmd FileType json set formatoptions=tcq2l
"	autocmd FileType json set textwidth=78 shiftwidth=2
"	autocmd FileType json set softtabstop=2 tabstop=8
"	autocmd FileType json set expandtab
"	autocmd FileType json set foldmethod=syntax
"augroup END 
"
"GVim for windows stuff

if has ("gui_win32")
	set sessionoptions+=resize  " Allow sessions to capture full window size on gvim
	autocmd BufRead,BufNewFile *.vis source %
endif
