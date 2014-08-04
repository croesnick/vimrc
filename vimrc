""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"	Carsten Rösnick (github: croesnick)
"
" Version: 0.1
"
" This .vimrc is based on Amir Salihefendic's version 5.0 posted at
" 	http://amix.dk/blog/post/19691#The-ultimate-Vim-configuration-on-Github
"
" However, I added a few commands to make life easier (especially for the
" LaTeX loving people out there). Most of what I know about VIMScript comes
" from Steve Losh's excellent book "Learn VIMScript the Hard Way".
"
" Important:
" 	Command to toggle folding is {normal} za
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vimscript file settings ------------------------------------------------ {{{
" ------------------------------------------------------------------------
" Command to toggle folding is 'za' {normal}
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
	autocmd FileType vim setlocal foldlevelstart=0
augroup END
" }}} ------------------------------------------------------------------------

" General VIM settings --------------------------------------------------- {{{
" ------------------------------------------------------------------------
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","
let g:maplocalleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Shorthand for "(e)dit (v)imrc in a split buffer"
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" "(S)ource the updated (v)imrc"; i.e., load its updates in the currently opened file
nnoremap <leader>sv :source $MYVIMRC<cr>

" Go to the first character of the line
nnoremap <leader>h 0
" Go to the last (possibly blank) character of the line
nnoremap <leader>l $

" Shortcut for "go to older/last highlighted tag"
nnoremap <leader>jb CTRL-T
" Jump forward to the tag
nnoremap <leader>jf CTRL-]
" }}} ------------------------------------------------------------------------

" LaTeX-related settings and mappings ------------------------------------ {{{
" -----------------------------------------------------------------------
let g:Tex_DefaultTargetFormat='pdf'

augroup aucmdlatex
	" Clear the group
	autocmd!
	autocmd FileType tex setlocal number

	" Prepend LaTeX comments to visually selected lines
	function! LaTeXCommentOut()
		" Necessary; updates '< and '>
		execute "normal! <cr>"
		let vline = line("'<")
		let vend  = line("'>")
		while vline <= vend
			" Go to line {vline}
			execute ":".vline
			" Switch to insert mode, add the comment, and switch back to
			" normal mode
			execute ":normal! gI%\<esc>"
			let vline = vline + 1
		endwhile
	endfunction

	function! LaTeXCommentIn() range
		execute a:firstline . ',' . a:lastline . 's/\v^\%//'
	endfunction

	" (C)omment (t)ext
	autocmd FileType tex vnoremap <leader>ct :execute "<c-u>call LaTeXCommentOut()<cr>"
	" (U)n(c)omment (t)ext
	autocmd FileType tex vnoremap <leader>uct :call LaTeXCommentIn()<cr>
	
	" Little helper commands for inserting typical LaTeX stuff
	" ========================================================
	
	" wraps the current word in a \begin{word} ... \end{word}
	autocmd FileType tex nnoremap <leader>ee "ayiwdiwI\begin{<esc>"apa}<cr><cr>\end{<esc>"apa}<esc>ki

	" Directly insert the most common environments
	" enumerate and itemize
	autocmd FileType tex nnoremap <leader>ie o\begin{enumerate}<cr>\item<space><cr>\end{enumerate}<esc>k$a
	autocmd FileType tex nnoremap <leader>ii o\begin{itemize}<cr>\item<space><cr>\end{itemize}<esc>k$a
	" theorem, lemma, ...
	autocmd FileType tex nnoremap <leader>it o\begin{theorem}<space>\label{thm:}<cr><cr>\end{theorem}<esc>ki
	autocmd FileType tex nnoremap <leader>il o\begin{lemma}<space>\label{lem:}<cr><cr>\end{lemma}<esc>ki
augroup END
" }}}-------------------------------------------------------------------------

" VIM user interface ----------------------------------------------------- {{{
" ------------------------------------------------------------------------
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Highlight on overlength
if exists('+colorcolumn')
    set colorcolumn=79
    highlight link OverLength ColorColumn
    exec 'match OverLength /\%'.&cc.'v.\+/'
endif
" }}} ------------------------------------------------------------------------

" Vundle plugin manager: settings and bundles ---------------------------- {{{
" ------------------------------------------------------------------------
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" REQUIRED: let Vundle manage Vundle
Bundle 'gmarik/vundle'

" My Bundles here:
Bundle 'potion'
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
" Bundle 'minibufexplorerpp'
"" Full-automatic compilation of LaTeX documents from VIM using Rubber
Bundle 'TeX-PDF'
" Bundle 'AutomaticLaTexPlugin'
"" Spellchecker that ignores LaTeX commands
Bundle 'SpellChecker'
"" Color scheme tailor-made for LaTeX
Bundle 'Neverness-colour-scheme'
" non github repos
Bundle 'Command-T'
Bundle 'git://github.com/vim-scripts/peaksea.git'
Bundle 'git://github.com/samdraz/slimv.git'
" YouCompleteMe auto-complete plugin
"Bundle 'Valloric/YouCompleteMe'
filetype plugin indent on     " required!

" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
" }}} ------------------------------------------------------------------------

" Colors and Fonts ------------------------------------------------------- {{{
" Enable syntax highlighting
syntax enable
" Enable 256 colors
set t_Co=256

colorscheme neverness
set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
	set guioptions-=T
	set guioptions+=e
	set guitablabel=%M\ %t
"	set guifont=Monospace:h20
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac
" }}} ------------------------------------------------------------------------

" Files, backups and undo ------------------------------------------------ {{{
" ------------------------------------------------------------------------
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
" }}} ------------------------------------------------------------------------

" Text, tab and indent related ------------------------------------------- {{{
" ------------------------------------------------------------------------
" Do NOT use spaces instead of tabs
set noexpandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 3 spaces
set shiftwidth=3
" set softtabstop=3
set tabstop=3

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
" }}} ------------------------------------------------------------------------

" Visual mode related ---------------------------------------------------- {{{
" ------------------------------------------------------------------------
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
" }}} ------------------------------------------------------------------------

" Moving around, tabs, windows and buffers ------------------------------- {{{
" ------------------------------------------------------------------------
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
	set switchbuf=useopen,usetab,newtab
	set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif
" Remember info about open buffers on close
set viminfo^=%
" }}} ------------------------------------------------------------------------

" Status line ------------------------------------------------------------ {{{
" ------------------------------------------------------------------------
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
" }}} ------------------------------------------------------------------------

" Text editing ----------------------------------------------------------- {{{
" ------------------------------------------------------------------------
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
	nmap <D-j> <M-j>
	nmap <D-k> <M-k>
	vmap <D-j> <M-j>
	vmap <D-k> <M-k>
endif

" Put visually selected text in double quotes
vnoremap <leader>qt <esc>`<i"<esc>`>a"<esc>

" Mark trailing whitespaces in red
highlight TrailingWhitespaces ctermbg=red guibg=red
nnoremap <leader>tw :execute 'match TrailingWhitespaces /\v\s+$/'<cr>

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.sh :call DeleteTrailingWS()
autocmd BufWrite *.tex :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
"autocmd BufWrite *.tex :call DeleteTrailingWS()
" }}} ------------------------------------------------------------------------

" vimgrep searching and cope displaying ---------------------------------- {{{
" ------------------------------------------------------------------------
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>
" }}} ------------------------------------------------------------------------

" Spell checking --------------------------------------------------------- {{{
" ------------------------------------------------------------------------
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=
" }}} ------------------------------------------------------------------------

" Misc ------------------------------------------------------------------- {{{
" ------------------------------------------------------------------------
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>
" }}} ------------------------------------------------------------------------

" C/C++ Settings --------------------------------------------------------- {{{
" ------------------------------------------------------------------------
autocmd FileType cpp setlocal number expandtab shiftwidth=2 tabstop=2
" }}}-------------------------------------------------------------------------

" Helper functions ------------------------------------------------------- {{{
" ------------------------------------------------------------------------
function! CmdLine(str)
	exe "menu Foo.Bar :" . a:str
	emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
	let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
		execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
	let l:currentBufNum = bufnr("%")
	let l:alternateBufNum = bufnr("#")

	if buflisted(l:alternateBufNum)
		buffer #
	else
		bnext
	endif

	if bufnr("%") == l:currentBufNum
		new
	endif

	if buflisted(l:currentBufNum)
		execute("bdelete! ".l:currentBufNum)
	endif
endfunction

function! WC()
	let filename = expand("%")
	let cmd = "detex " . filename . " | wc -w | tr -d [:space:]"
	let result = system(cmd)
	echo result . " words"
endfunction

command WC call WC()

" }}} ------------------------------------------------------------------------
