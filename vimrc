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

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

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

"------------------
" Gerneral Settings
" -----------------
set vb " Visual Bell
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
set wildmode=list:longest
set ignorecase
set smartcase
set shiftround
set autoindent
set copyindent
set wildignore=*.swp,*.bak,*.pyc,*.class,*.beam,*.o
" set shortmess=atI
" set autochdir
set nobackup
set noswapfile

"-------
" Macros
"-------
runtime macros/matchit.vim

" ----
" Font
" ----
" set guifont=Menlo:h13
set guifont=Anonymous\ Pro\ 13

" -------
" Display
" -------
set antialias
" set nomacatsui
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
set laststatus=2
set number " Line Number
colorscheme vividchalk

" ----------
" Formatting
" See fo-table
" ----------
" set fo+=a

" ------
" CScope
" ------
set cst

" --------------
" Spell Checking
" --------------
set spellfile=~/.vim/spellfile.add

" ---------
" Skeletons
" ---------
:autocmd BufNewFile *.rb  0r ~/.vim/skeletons/skel.rb
:autocmd BufNewFile *.sbt 0r ~/.vim/skeletons/skel-sbt.sbt
:autocmd BufNewFile rebar.config 0r ~/.vim/skeletons/skel-rebar.erl
:autocmd FileType ruby setlocal sts=2 sw=2 ts=2 et
:autocmd FileType xml setlocal sts=2 sw=2 ts=2 et
:autocmd FileType html setlocal sts=2 sw=2 ts=2 et
:autocmd FileType javascript setlocal sts=2 sw=2 ts=2 et

" --------
" Pathagen
" --------
filetype off 
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

" -------
" Tagbar
" -------
let g:tagbar_ctags_bin = '/usr/bin/ctags'

" --------
" Easytags
" --------
let g:easytags_cmd  = '/usr/bin/ctags'
" let g:easytags_autorecurse = 1

" -------
" Mapping
" -------
let g:EasyMotion_mapping_t = '_t'
cmap w!! w !sudo tee % >/dev/null
nmap <unique> <silent> <Leader>f :CommandTFlush<CR>
nmap <unique> <silent> <Leader>s :Gstatus<CR>
nmap <unique> <silent> <Leader>gc :Gcommit<CR>
nmap <unique> <silent> <Leader>l :TlistToggle<CR>
" http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

