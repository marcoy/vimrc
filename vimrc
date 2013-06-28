" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Nov 16
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" --------
" Pathagen
" --------
call pathogen#infect()
call pathogen#helptags()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a
set ttymouse=xterm2

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis

let s:is_windows = has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_macvim = has('gui_macvim')

"------------------
" Gerneral Settings
" -----------------
set vb " Visual Bell
set noerrorbells
set showmatch
set mousehide
set sts=4
set ts=4
set sw=4
set et
set smarttab
set hidden
let mapleader = ","
set history=1000
set undolevels=1000
set wildmenu
set wildmode=list:longest,full
set keywordprg=":help" " remap K to vim help
set ignorecase
set smartcase
set shiftround
set autoindent
set copyindent
set smartindent
set showfulltag
set wildignore=*.swp,*.bak,*.pyc,*.class,*.beam,*.o
set ttyfast
set nobackup
set noswapfile
set shortmess+=filmnrxoOtT
set scrolljump=5
"set scrolloff=5

if exists('$TMUX')
    set clipboard=
else
    set clipboard=unnamed " sync with OS clipboard
endif

if executable('ag')
    set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
    set grepformat=%f:%l:%c:%m
endif
if executable('ack')
    set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
    set grepformat=%f:%l:%c:%m
endif


"-------
" Macros
"-------
runtime macros/matchit.vim


" ----
" Font
" ----
if s:is_macvim
    set guifont = Anonymous\ Pro:h14
    set transparency=2
else
    set guifont=Mensch\ 11
endif


" -------
" Display
" -------
set background=dark
set antialias
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
set number " Line Number
set list
set cursorline
set splitbelow
set splitright
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅,precedes:❮,extends:❯

set linebreak
set showbreak=↪\ 

set statusline=%f
set statusline+=%m      "modified flag
set statusline+=\ %y      "filetype
set statusline+=%h      "help file flag
set statusline+=%r      "read only flag
set statusline+=%{fugitive#statusline()}
"display a warning if paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*
"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*
set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

" ------
" CScope
" ------
set cst

" --------------
" Spell Checking
" --------------
set spellfile=~/.vim/spellfile.add

" ----------
" Completion
" ----------
set completeopt=longest,menuone,preview
set ofu=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType ant set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType clojure set omnifunc=vimclojure#OmniCompletion

" ---------
" Skeletons
" ---------
autocmd BufNewFile *.rb  0r ~/.vim/skeletons/skel.rb
autocmd BufNewFile *.sbt 0r ~/.vim/skeletons/skel-sbt.sbt
autocmd BufNewFile rebar.config 0r ~/.vim/skeletons/skel-rebar.erl
autocmd FileType ruby setlocal sts=2 sw=2 ts=2 et
autocmd FileType xml setlocal sts=2 sw=2 ts=2 et
autocmd FileType ant setlocal sts=2 sw=2 ts=2 et
autocmd FileType html setlocal sts=2 sw=2 ts=2 et
autocmd FileType javascript setlocal sts=2 sw=2 ts=2 et

" -------
" Tagbar
" -------
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_autofocus = 1


" -------
" Paredit
" -------
let g:paredit_smartjump = 1
let g:paredit_matchlines = 200


" -----------
" Neocomplete
" -----------
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_at_startup = 1
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()


" -----
" Unite
" -----
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('file,file/new,buffer,file_rec,line',
                       \ 'matchers', 'matcher_fuzzy')
let g:unite_enable_smart_case = 1
let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1
let g:unite_prompt = '» '


" ----------
" Processing
" ----------
let g:use_processing_java = 1


" -------
" Mapping
" -------
let g:EasyMotion_mapping_t = '_t'
cmap w!! w !sudo tee % >/dev/null
nmap <unique> <silent> <Leader>f :CommandTFlush<CR>
nmap <unique> <silent> <Leader>s :Gstatus<CR>
nmap <unique> <silent> <Leader>gc :Gcommit<CR>
nmap <unique> <silent> <Leader>b :TagbarToggle<CR>

" http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

"Make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"Map jk -> escape
inoremap jk <esc>

colorscheme solarized
