"Initiliazation settings {{{1
set nocompatible     "This must be first
set autoread         "Reload a file automatically when changed from outside
set mouse=a          "Let me use the mouse in xterms

"Make VIM behave like show-all-if-ambiguous is set like .inputrc
set backspace=indent,eol,start		" allow backspacing over everything in insert mode
set autoindent			" always set autoindenting on
set path=.,,,**   " For find command  - dont think i use this anymore
set backup		" keep a backup file
set background=dark
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set autowrite   " Auto write files on buffer moves & makes
set hidden "Let me move around if buffers aren't saved
set shortmess=a
set title
set nowrap "I seem to be preferring this recently
set shiftwidth=2
set scrolloff=1 "I really like this with [m & ]m


"Tab setup default for all filemodes
set tabstop=2 "Number of visual spaces per TAB in a file I read
set softtabstop=2 "Number of spaces in TAB when editing
set expandtab     "Tab is now a shortcut to a bunch adding 2 spaces


"UI Config
set showmatch             "Show matching brackets
set showcmd               "Show in status bar, in progress commands
set number                "Turn on line numbering by default
syntax on
"hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
"set cursorline           " Underline current line for easy cursor spotting 
augroup CursorLine
	au!
	au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
	au WinLeave * setlocal nocursorline
augroup END

filetype  plugin indent on      "Load filetype specific indent files and ftplugin settings


"Let's play with this a bit and see how i like it....
"autocmd BufEnter   * if expand('%:p') !~ '://'  | silent lcd %:p:h | endif
"autocmd BufWinEnter * if expand("%") != "" | silent loadview | endif
"autocmd BufWinLeave * if expand("%") != "" | silent mkview! | endif

"runtime macros/matchit.vim "matchit ships with vim now


"Diff setup {{{1
set diffopt=filler,iwhite,vertical
set diffexpr=""
"}}}1

"NETRW Settings {{{1
let g:netrw_banner = 0          "disable banner
let g:netrw_browse_split=0
let g:netrw_preview = 1
let g:netrw_liststyle = 3
let g:netrw_winsize = 30
"browse_split =4 open in prior window, netrw_altv=1 open splits to right
"list_hide=netrw_gitignore#Hide() , list_hide.=',\.....'

" Search Settings {{{1
set gdefault         "Behave like /g is always set on substitute commands
set incsearch        "do incremental searching
set hlsearch         "Highlight search results
set matchtime=3
set ignorecase       "Case insestive searching by default
set smartcase        "If capital letter in search then be case sensitive

"I like this search highlighting more then default
highlight IncSearch ctermfg=red
highlight Search ctermfg=red ctermbg=white

" Switch syntax highlighting on, when the terminal has colors Also switch on
" highlighting the last used search pattern.
" }}}1

" Don't use Ex mode, use Q for formatting
map Q gq

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

nnoremap gp `[v`]

nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>

nnoremap q: <NOP>  "Can use Cf from prompt if needed
nnoremap q/ <NOP>  "Can use Cf from prompt if needed
nnoremap q? <NOP>  "Can use Cf from prompt if needed

nnoremap <silent> <CR> :nohlsearch<CR>/<BS><CR>
nnoremap <F1> :SearchReset<CR>
"imap <F1> <ESC>:set hlsearch!<CR>a
"noremap % v%

nnoremap <expr> dd match(getline('.'),'^$*$') == -1 ? 'dd':'"_dd'

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



"}}}1

" Only do this part when compiled with support for autocommands.

augroup text_stuff
	autocmd!

	autocmd BufRead,BufNewFile *.txt set filetype=text 
	autocmd BufRead,BufNewFile todo.txt set nobackup nowrap
	autocmd BufRead,BufNewFile vimhelp.txt set nobackup nowrap
	autocmd BufRead,BufNewFile putty*   set filetype=text
	autocmd BufRead,BufNewFile typescript*   set filetype=text

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

	"Figure out how to set this only for certain types of files, it screws up
	"some auto buffers with unmodifiable error messages
	autocmd FileType text if &modifiable | silent %s///ge | endif
augroup END

"Automatically open compiler output window across bottom of vim, if errors.
autocmd QuickFixCmdPost * botright cwindow 5

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

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

"Quick Access File Helpers
nmap ,v :e ~/.vimrc<CR>
autocmd! bufwritepost .vimrc source ~/.vimrc

nmap ,a :e ~/.bash_aliases<CR>
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
autocmd FileType sh,make,perl,gdb,conf,python      let b:comment_leader = '# '
noremap <silent> ,c :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> ,u :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>

"I actually want tag in same place, use Cwg} to preview it.
"nnoremap <C-]> <Esc>:exe "ptjump " . expand("<cword>")<Esc>
nnoremap <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"StatusLine settings
set laststatus=2 "Always show
"set statusline=%<\ %n:%f\ %m%r%y%=%-35. (line: \ %1\ of \ %L,\ col:\ %c%V\ (%P)%)
"set statusline=%n:%f\ %m%r%y%=%-35. (line: \ %1\ of \ %L,\ col:\ %c%V\ (%P)%)
"set statusline=%n:%F%m%r%h%w\%=[L:\%l\ C:\%c\ A:\%b\ H:\x%B\ P:\%p%%]
set statusline=%F\ %y\ %m\ %r%h%w\ [\%l,\%c\ \%p%%]
"set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
 
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


" New Stuff since rhub was made

"SessionOptions {{{1
"if has ("gui_win32")
	set sessionoptions+=resize  " Allow sessions to capture full window size on gvim
	autocmd BufRead,BufNewFile *.vim source %
	autocmd BufRead,BufNewFile *.vis source %
"endif
"}}}1

"GUI Mode {{{1
if has("gui_running")
	"  highlight Type      ctermfg=green
	"  highlight Statement ctermfg=1
	"  highlight 
	hi Search guibg=LightBlue
	set background=light
	set guioptions-=T "get rid of toolbar
	set guioptions-=m "get rid of menu
endif
"}}}1


