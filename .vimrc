" vim: set foldenable foldmethod=marker foldlevel=0:

"Todo {{{1
"Fix all the folding stuff
"Using: github.com/naruyan/nar/blobl/master/.vimrc as a template
"}}}1

"Initiliazation settings {{{1
set nocompatible     "This must be first
set autoread         "Reload a file automatically when changed from outside
set mouse=a          "Let me use the mouse in xterms
"Make VIM behave like show-all-if-ambiguous is set like .inputrc
set wildmode=longest:list,full "Make VIM behave like a show-all-if-ambigous is set like in .inputrc
set showcmd "Show in status bar, in progress commands
set backspace=indent,eol,start		" allow backspacing over everything in insert mode
set autoindent			" always set autoindenting on
set backup		" keep a backup file
set background=dark
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set autowrite   " Auto write files on buffer moves & makes
set number "Turn on line numbering by default
if version > 702
set relativenumber "Turn on relative numbering
endif
set hidden "Let me move around if buffers aren't saved
set shortmess=a
set cmdheight=1
set title
set nowrap "I seem to be preferring this recently
set tabstop=2
set scrolloff=1 "I really like this with [m & ]m
set foldopen+=jump
"hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
augroup CursorLine
	au!
	au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
	au WinLeave * setlocal nocursorline
augroup END

filetype plugin indent on

if &t_Co > 2
  syntax on
endif

"}}}1


"Let's play with this a bit and see how i like it....
autocmd BufEnter   * if expand('%:p') !~ '://'  | silent lcd %:p:h | endif
autocmd BufWinEnter * if expand("%") != "" | silent loadview | endif
autocmd BufWinLeave * if expand("%") != "" | silent mkview! | endif

runtime macros/matchit.vim "matchit ships with vim now
runtime ftplugin/man.vim  "Gives :Man command

"Fugitive setup {{{1
autocmd BufReadPost fugitive://* set bufhidden=delete  "Stop million buffers when running through hash

"}}}1


"Diff setup {{{1
set diffopt=filler,iwhite,vertical
set diffexpr=""
"}}}1

"NETRW Settings {{{1
let g:netrw_preview = 1
let g:netrw_liststyle = 3
let g:netrw_winsize = 30
"}}}1

"C Stuff (Commented out) {{{1
"I moved this to a cpp.vim ftplugin, but not sure if i want it for other types
"of files
"C indention stuff... See help 'cinoptions-values'
"set smartindent
"set tabstop=2
"set shiftwidth=2
"set softtabstop=2
"set cino+=(0             "Align paramater lists after newline under '('
"set cino+=l1 "Indent switch/case lines better 
"set cino+=N-s "Don't indent for namespaces
""set cino+=e-1s  "No indent if '{' is not on its own line (Turns out i hate this)
"set formatoptions-=r "Stop auto commenting on new lines
"set formatoptions-=o "Stop auto commenting on Oo
"}}}1

" Search Settings {{{1
set gdefault         "Behave like /g is always set on substitute commands
set incsearch	     "do incremental searching
set hlsearch         "Highlight search results
set showmatch        "Show matching brackets
set matchtime=3
set ignorecase       "Case insestive searching by default
"set smartcase        "If capital letter in search then be case sensitive

"I like this search highlighting more then default
highlight IncSearch ctermfg=red
highlight Search ctermfg=red ctermbg=white

" Switch syntax highlighting on, when the terminal has colors Also switch on
" highlighting the last used search pattern.
if has("gui_running")
"  highlight Type      ctermfg=green
"  highlight Statement ctermfg=1
"  highlight 
  hi Search guibg=LightBlue
	set background=light
	set guioptions-=T "get rid of toolbar
	set guioptions-=m "get rid of menu
endif


" }}}1

" Don't use Ex mode, use Q for formatting
map Q gq


" ShowMarks Setup {{{1
"
"let showmarks_enable = 0
""let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.'`^<>[]{}()\""
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.'`^"
let g:showmarks_ignore_type = "hqrmp"
let g:showmarks_ignore_name = "ctrlp.txt"
"
"let showmarks_textlower = "\t:"
"let showmarks_textupper = "\t:"
"let showmarks_textother = "\t:"
" }}} 1

"Visual Mode Configuration {{{1
"
" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch()
	let temp = @s
	norm! gv"sy
	let @/ = '\V' . substitute(escape(@s, '/\'), '\n','\\n','g')
	let @s = temp
endfunction

vnoremap ;; :%s:::g<Left><Left><Left>
vnoremap ;' :%s:::cg<Left><Left><Left><Left>

"Visual block search
vnoremap <silent> g/     y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vnoremap <silent> g?     y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" Search for selected text, forwards or backwards
vnoremap <silent> * :<C-U>
			\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
			\gvy/<C-R><C-R>=substitute(
   \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
   \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
   \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
vnoremap * y/\V<C-R>=substitute(escape(@@,"/\\"),"\n","\\\\n","ge")<CR><CR> 
vnoremap # y?\V<C-R>=substitute(escape(@@,"?\\"),"\n","\\\\n","ge")<CR><CR>


"}}}1

"Normal Mode Mapping {{{1

nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>

nnoremap q: <NOP>  "Can use Cf from prompt if needed
nnoremap q/ <NOP>  "Can use Cf from prompt if needed
nnoremap q? <NOP>  "Can use Cf from prompt if needed

nnoremap <silent> <CR> :nohlsearch<CR>/<BS><CR>
nnoremap <F1> :SearchReset<CR>
"imap <F1> <ESC>:set hlsearch!<CR>a
"noremap % v%

"I Just like this as an example {{{2
"if has("unix")
	"map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
	"nnoremap ,se :e scp://user@host//pathtofile<C-f>Fu<C-c>
	"nnoremap ,se :e scp://userAThost//pathtofile<C-f>Fu
"else
	"map ,e :e <C-R>=expand("%:p:h") . "\\" <CR>
"endif
"}}}2

nnoremap <C-w>+ <C-w><Bar><C-w>_


"Buffer Navigation: {{{2
" ":e <filename>" to make a buffer with that file in it (duh)
" ",s" and ",f" for back and forth on the buffer list
" " ",b" for a list of what's in each buffer
" " ",1", ",2", .. ",9", ",0" to go straight to that numbered buffer (0 = 10)
" " ",g" to toggle between two buffers (my most used probably)
nnoremap ,se :e scp://userAThost//pathtofile<C-f>Fu
nnoremap <silent>,p :bN<CR>
nnoremap <silent>,n :bn<CR>
nnoremap <silent>,H :call HideMe("PREV")<CR>
nnoremap <silent>,h :call HideMe("NEXT")<CR>
"map ,b :buffers<CR>
nnoremap <silent>,b :CtrlPBuffer<CR>
"nnoremap <silent>T :CtrlPBufTag<CR>
"nnoremap <silent>t :CtrlPTag<CR>
nnoremap <silent>,e :CtrlPCurWD<CR>
nnoremap <silent>,m :CtrlPMRU<CR>
"nnoremap <silent>m :CtrlPMixed<CR>
"nnoremap <silent>l :CtrlPLine<CR>
map ,# :e#<CR>
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
"}}}2

"}}}1

" Only do this part when compiled with support for autocommands.
if has("autocmd")

augroup text_stuff
	autocmd!

	autocmd BufRead,BufNewFile *.txt set filetype=text 
	autocmd BufRead,BufNewFile todo.txt set nobackup nowrap
	autocmd BufRead,BufNewFile vimhelp.txt set nobackup nowrap
	autocmd BufRead,BufNewFile putty*   set filetype=text
	autocmd BufRead,BufNewFile typescript*   set filetype=text

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal tw=78

	"Figure out how to set this only for certain types of files, it screws up
	"some auto buffers with unmodifiable error messages
	autocmd FileType text if &modifiable | silent %s///ge | endif



augroup END

	autocmd! bufwritepost .vimrc source ~/.vimrc


	"Automatically open compiler output window across bottom of vim, if errors.
	autocmd QuickFixCmdPost * botright cwindow 5



  " When editing a file, always jump to the last known cursor position.
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")


 
"func! HideAll()
	"syn region myFold start="{" end="}" transparent fold
	"syn sync fromstart
	"set foldnestmax=2
	"set foldmethod=syntax
"endfunc

map <F9> call HideAll()


fun! HideAllJsonShit()
				g/: {/normal! zf%
				g/: \[/normal! zf%
endfun
fun! HideJsonShit()
				g/GEO_SCOPE/normal! zf%
				g/NMS/normal! zf%
				g/SERVICE/normal! zf%
				g/TRAFFIC_FILTER/normal! zf%
endfun
nmap <F8> :call HideJsonShit()<CR>
nmap <S-F8> :call HideAllJsonShit()<CR>

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




set wildignore=*.o,*~,*.a,*.d

"Compile shortcuts...
nmap <F2> :ccl <CR>
nmap <F3> :cp <CR>
nmap <F4> :cn <CR>

nmap <F5> :ls<cr>:b! #<space>
nmap <S-F5> :ls!<cr>:b!<space> 


set tags=tags;/home/bsnyder/work
"set tags=$id/tags
" Nice way of auto centering the current line as i move around.
"set scrolloff=99999      

"Quick Access File Helpers
nmap ,x :source ~/.vimrc<CR>
nmap ,v :e ~/.vimrc<CR>
nmap ,z :e ~/.zshrc<CR>
nmap ,a :e ~/.alias<CR>
nmap ,g :e ~/.gitconfig<CR>
nmap ,d :e ~/dotfiles<CR>



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

cab man Man

"I actually want tag in same place, use Cwg} to preview it.
"nnoremap <C-]> <Esc>:exe "ptjump " . expand("<cword>")<Esc>
nnoremap <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"StatusLine settings
set laststatus=2 "Always show
"set statusline=%<\ %n:%f\ %m%r%y%=%-35. (line: \ %1\ of \ %L,\ col:\ %c%V\ (%P)%)
"set statusline=%n:%f\ %m%r%y%=%-35. (line: \ %1\ of \ %L,\ col:\ %c%V\ (%P)%)
"set statusline=%n:%F%m%r%h%w\%=[L:\%l\ C:\%c\ A:\%b\ H:\x%B\ P:\%p%%]


set statusline=%F\ %m\ %r%h%w\ %{fugitive#statusline()}%=\%n\ [\%l,\%c\ \%p%%]
"set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
 
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

cab vtag vertical stag


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



"Multiple Search helpers
"Help cleaning up routr files
fun! DoSearchRouter()
 SearchBuffers uprtrASR1k#
 SearchBuffers uprtrASR1k(config)#
 SearchBuffers uprtrASR1k(config-.*)#
endfun
let @a='/h2xh'

"Some git help
"map <silent> <f7> :call GITLOG_ToggleWindows()<CR>

"DCL STUFF {{{1
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
"End DCL Stuff}}}1


"CTRLP Configuration {{{1
"Not sure I want this right now, just moved ctrlp.vim into regular structure
"set runtimepath^=~/.vim/bundle/ctrlp.vim

"Can use wildignore to set files it will ignore and/or ctrlp_custom_ignore to
"add to it for just ctrlp scope

let g:ctrlp_by_filename = 1 "Use search by filename by default

"}}}1

autocmd BufNewFile,BufRead *.opt set filetype=json
autocmd BufNewFile,BufRead *.json set filetype=json
"autocmd BufNewFile,BufRead *.json set filetype=json syntax=javascript



"Windows stuff {{{1
if has ("gui_win32")
	set sessionoptions+=resize  " Allow sessions to capture full window size on gvim
	autocmd BufRead,BufNewFile *.vim source %
	autocmd BufRead,BufNewFile *.vis source %
endif
"}}}1
