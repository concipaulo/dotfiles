"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"       _                    
"__   _(_)_ __ ___  _ __ ___ 
"\ \ / / | '_ ` _ \| '__/ __|
" \ V /| | | | | | | | | (__ 
"  \_/ |_|_| |_| |_|_|  \___|
"                            
" Maintainer:
"       Paulo Conci
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" if empty(glob('~/.vim/autoload/plug.vim')) silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim autocmd
" VimEnter * PlugInstall --sync | source $MYVIMRC 
" endif 

call plug#begin('~/.vim/plugged') 
Plug 'tpope/vim-sensible'
Plug 'junegunn/goyo.vim'
" Plug 'https://github.com/coldfix/hexHighlight.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/vim-syntastic/syntastic.git'
Plug 'tpope/vim-abolish'
Plug 'vim-airline/vim-airline' 
Plug 'vim-airline/vim-airline-themes' 
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'dylanaraps/wal.vim'
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'ap/vim-css-color'
call plug#end()

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"
syntax on
"Airline theme
let g:airline_theme='wal'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#ctrlp#enable = 1
let g:CtrlSpaceStatuslineFunction = "airline#extensions#ctrlspace#statusline()"
"let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])
let g:airline#extensions#whitespace#show_message = 0
let g:airline#extensions#whitespace#enable = 0
" let g:airline_whitespace_disable = 1
"
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''

" Use fd for ctrlp.
if executable('fd')
    let g:ctrlp_user_command = 'fd -c never "" %s'
    let g:ctrlp_use_caching = 0
endif

" Vimtex settings
" " Note; <leader>ll builds and <leader>le shows compile errors
" " Note; install xdotool package for live previews in zathura
" " let g:vimtex_view_method='general'
"let g:vimtex_view_method='zathura'
"let g:airline#extensions#vimtex#enable=1


" " Nerdtree settings
" " launch nerdtree on entry if no file is specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"set autochdir                " automatically change directory
"let NERDTreeChDirMode=2
let g:nerdtree_tabs_open_on_gui_startup=0

set ttimeout
set timeoutlen=1000 ttimeoutlen=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=2000

set nocompatible

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
"let mapleader = ","
"let g:mapleader = ","

"omni completation
"set omnifunc=syntaxcomplete#Complete

"Cursor in different modes
"let &t_SI = "\<Esc>[6 q"
"let &t_SR = "\<Esc>[4 q"
"let &t_EI = "\<Esc>[2 q"

"Took from some geek I cant remember
if &term =~ "xterm\\|rxvt"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;orange\x7"
  " use a red cursor otherwise
  let &t_EI = "\<Esc>]12;gray\x7"
  silent !echo -ne "\033]12;gray\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
  " use \003]12;gray\007 for gnome-terminal and rxvt up to version 9.21
endif

"let g:syntastic_quiet_messages = {
"    \ "!level":  "errors",
"    \ "type":    "style",
"    \ "regex":   '\m\[C03\d\d\]',
"    \ "file:p":  ['\m^/usr/include/', '\m\c\.h$'] }

let g:syntastic_quiet_messages = { "level": "warnings" }
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set lines to the cursor - when moving vertically using j/k
set so=6

" Turn on the WiLd menu 
set wildmode=longest,list

" Ignore compiled files
"set wildignore=*.o,*~,*.pyc
"if has("win16") || has("win32")
"    set wildignore+=.git\*,.hg\*,.svn\*
"else
"    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
"endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
"set ignorecase

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

" Add a bit extra margin to the left
"set foldcolumn=1

"Add number lines 
set number
set relativenumber
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
" syntax enable
set t_Co=256
"
" let g:seoul256_background=237
" let g:seoul256_srgb = 1
" colorscheme seoul256
colorscheme wal
"
set background=dark
"
" Set extra options when running in GUI mode
"if has("gui_running")
"    set guioptions-=T
"    set guioptions-=e
"    set t_Co=256
"    set guitablabel=%M\ %t
"endif
"
" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
"
" Use Unix as the standard file type
set ffs=unix,dos,mac
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git
set nobackup
set nowb
set noswapfile
"
"Folding 
au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview
"
"Markdown files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
"let g:markdown_fenced_languages = ['html', 'python', bash=sh']
"let g:markdown_syntax_conceal = 0
"let g:markdown_minlines = 100
"let vim_markdown_preview_github=1
"let vim_markdown_preview_perl=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab
"
" Be smart when using tabs ;)
set smarttab
"
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
"
" Linebreak on 80 characters
set lbr
set tw=79
"
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
"map <space> /
"map <c-space> ?
"
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>
"
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
"
" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT
"
" Close all the buffers
map <leader>ba :bufdo bd<cr>
"
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>
"
" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>tl :tabnext
map <leader>q  :cclose<cr>
map <leader>o  :copen<cr>
map <leader>g :Goyo<CR>
"
function! GoyoAfter()
    set background=dark
endfunction
"
" Let 'tl' toggle between this and the last accessed tab
"let g:lasttab = 1
"nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
"au TabLeave * let g:lasttab = tabpagenr()
"
"
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
" map <leader>cd :cd %:p:h<cr>:pwd<cr>
"
map <leader>S :SyntasticToggleMode<CR>
"
" Specify the behavior when switching between buffers
" try
"   set switchbuf=useopen,usetab,newtab
"   set stal=2
" catch
" endtry
"
" Return to last edit position when opening files (You want this!)
" au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2
"
" Format the status line
" set statusline=\ %{HasPaste()} \%{FugitiveStatusline()}\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
set statusline=\ %{FugitiveStatusline()}\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
" set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
" map 0 ^
"
" Delete trailing white space on save, useful for some filetypes ;)
" fun! CleanExtraSpaces()
"     let save_cursor = getpos(".")
"     let old_query = getreg('/')
"     silent! %s/\s\+$//e
"     call setpos('.', save_cursor)
"     call setreg('/', old_query)
" endfun
" "
" if has("autocmd")
"     autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
" endif
" "Easy expansion of the active file directory
" cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"NerdTree
map <leader>d :NERDTreeToggle<CR>

" Fast saving
nmap <leader>w :w!<cr>
"Fast closing
"nmap <leader>q :q<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null
command! Q q

" Another mappings
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
map <F9> :e $HOME/.vimrc<CR>
map <F6> :so $HOME/.vimrc<CR>
map <F7> :e $HOME/Articles/References/bibfile.bib<CR>
"
"nnoremap <leader>m :w<CR>:!rubber --pdf --warn all %<CR>
nnoremap <leader>m :w<CR>:!xelatex %<CR> :!bibtex %:r.aux <CR> :!xelatex %<CR> :!xelatex %<CR><CR>
nnoremap <leader>v :!zathura %:r.pdf &<CR><CR>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing \ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
"
" Shortcuts using <leader>
" map <leader>sn ]s
" map <leader>sp [s
" map <leader>sa zg
" map <leader>s? z=
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
"noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
"
" Quickly open a buffer for scribble
"map <leader>q :e ~/buffer<cr>
"
" Quickly open a markdown buffer for scribble
"map <leader>x :e ~/buffer.md<cr>
"
" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
" function! HasPaste()
"    if &paste
        " return 'PASTE MODE  '
    " endif
    " return ''
" endfunction

" Don't close window, when deleting a buffer
" command! Bclose call <SID>BufcloseCloseIt()
" function! <SID>BufcloseCloseIt()
"    let l:currentBufNum = bufnr("%")
"    let l:alternateBufNum = bufnr("#")

"    if buflisted(l:alternateBufNum)
"      buffer #
"    else
"      bnext
"    endif

"    if bufnr("%") == l:currentBufNum
"      new
"    endif

"    if buflisted(l:currentBufNum)
"      execute("bdelete! ".l:currentBufNum)
"    endif
" endfunction
"========================================================================
" vim to show comands on normal mode 
set showcmd

" syntastic 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


"remove arrowkeys
nnoremap <Up> :echo "No up for you!" <CR>
nnoremap <Down> :echo "No down for you!" <CR>
nnoremap <Left> :echo "No left for you!" <CR>
nnoremap <Right> :echo "No right for you!" <CR>

vnoremap <Up> :<C-u>echo "No up for you!" <CR>
vnoremap <Down> :<C-u>echo "No down for you!" <CR>
vnoremap <Left> :<C-u>echo "No left for you!" <CR>
vnoremap <Right> :<C-u>echo "No right for you!" <CR>

inoremap <Up> <C-o>:echo "No up for you!" <CR>
inoremap <Down> <C-o>:echo "No down for you!" <CR>
inoremap <Left> <C-o>:echo "No left for you!" <CR>
inoremap <Right> <C-o>:echo "No right for you!" <CR>

"laggy tex file ?
" autocmd FileType tex :NoMatchParen
" au FileType tex setlocal nocursorline
"
