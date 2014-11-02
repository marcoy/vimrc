" Inspired by https://github.com/terryma/dotfiles/blob/master/.vimrc
"             https://github.com/bling/dotvim/blob/master/vimrc

" Disable vi-compatibility
set nocompatible


"===============================================================================
" NeoBundle
"===============================================================================
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Use https protocol over proxy.
let g:neobundle#types#git#default_protocol = 'https'
let g:neobundle#install_max_processes = 20

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/tabpagebuffer.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-fireplace'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-jdaddy'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'kshenoy/vim-signature'
NeoBundle 'Lokaltog/vim-easymotion'
" NeoBundle 'ervandew/supertab'
" NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'guns/vim-clojure-static'
NeoBundle 'guns/vim-sexp'
NeoBundle 'rking/ag.vim'
NeoBundle 'amdt/vim-niji'
NeoBundle 'Raimondi/delimitMate'
" NeoBundle 'scrooloose/syntastic'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'justinmk/vim-sneak'
NeoBundle 'atweiden/vim-dragvisuals'
NeoBundle 'ludovicchabant/vim-lawrencium'
NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'honza/vim-snippets'
NeoBundle 'tfnico/vim-gradle'
NeoBundle 'ekalinin/Dockerfile.vim'
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle 'hewes/unite-gtags',{ 'external_commands' : 'gtags' }
NeoBundle 'vim-scripts/gtags.vim',{ 'external_commands' : 'gtags' }
NeoBundle 't9md/vim-choosewin'
NeoBundle 'wellle/targets.vim'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'tommcdo/vim-exchange'

" Colourscheme
NeoBundle 'tpope/vim-vividchalk'
NeoBundle 'whatyouhide/vim-gotham'
NeoBundle 'tomasr/molokai'

" Haskell
NeoBundle 'dag/vim2hs'
NeoBundle 'eagletmt/neco-ghc', { 'external_commands' : 'ghc-mod' }
NeoBundle 'eagletmt/ghcmod-vim', { 'external_commands' : 'ghc-mod' }
NeoBundle 'bitc/vim-hdevtools', { 'external_commands': 'hdevtools' }

call neobundle#end()

" Enable file type detection.
filetype plugin indent on
syntax enable

NeoBundleCheck


"===============================================================================
" OS Detection
"===============================================================================
let s:is_windows = has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_macvim = has('gui_macvim')


"===============================================================================
" General Settings
"===============================================================================

" Set augroup
augroup MyAutoCmd
    " Remvoe all autocommands for this group
    autocmd!
augroup END

"======[ Magically build interim directories if necessary ]======
function! AskQuit (msg, options, quit_option)
    if confirm(a:msg, a:options) == a:quit_option
        exit
    endif
endfunction

function! EnsureDirExists ()
    let required_dir = expand("%:h")
    if !isdirectory(required_dir)
        call AskQuit("Parent directory '" . required_dir . "' doesn't exist.",
             \       "&Create it\nor &Quit?", 2)

        try
            call mkdir( required_dir, 'p' )
        catch
            call AskQuit("Can't create '" . required_dir . "'",
            \            "&Quit\nor &Continue anyway?", 1)
        endtry
    endif
endfunction

augroup AutoMkdir
    autocmd!
    autocmd  BufNewFile  *  :call EnsureDirExists()
augroup END

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" show the cursor position all the time
set ruler

" display incomplete commands
set showcmd

" do incremental searching
set incsearch

" Turn on the mouse, since it doesn't play well with tmux anyway. This way I can
" scroll in the terminal
set mouse=a
set mousehide

" In many terminal emulators the mouse works just fine, thus enable it.
set ttymouse=xterm2

" Solid line for vsplit separator
set fcs=vert:│

" Give one virtual space at end of line
set virtualedit=onemore

" Turn on line number
set number

" Always splits to the right and below
set splitright
set splitbelow

" 256bit terminal
set t_Co=256

" Tell Vim to use dark background
set background=dark

" Sets how many lines of history vim has to remember
set history=10000

" Set to auto read when a file is changed from the outside
set autoread

" Display unprintable chars
set list
" set listchars=tab:⇥\ ,nbsp:·,trail:␣,extends:▸,precedes:◂
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅,precedes:❮,extends:❯
set showbreak=↪\ 
"set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣
"set showbreak=↪

" Open all folds initially
set foldmethod=indent
set foldlevelstart=99

" Auto complete setting
set completeopt=longest,menuone,preview

set wildmode=list:longest,full
set wildmenu "turn on wild menu
set wildignore=*.swp,*.bak,*.pyc,*.class,*.beam,*.o
set wildignore+=*.obj,*~,*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/Library/**,*/.rbenv/**
set wildignore+=*/.nx/**,*.app

" Allow changing buffer without saving it first
set hidden

" Case insensitive search
set ignorecase
set smartcase

" Set sensible heights for splits
"set winheight=50

" Make regex a little easier to type
set magic

" Show matching brackets
set showmatch

" Set encoding to utf-8
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" Turn backup off
set nobackup
"set nowritebackup
set noswapfile

" Tab settings
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab

" Text display settings
set copyindent
set smartindent
set linebreak
set textwidth=80
set autoindent
set nowrap
set whichwrap+=h,l,<,>,[,]

" A fast terminal connection
set ttyfast

" Use cscope and tag file
set cst

"           +--Disable hlsearch while loading viminfo
"           | +--Remember marks for last 50 files
"           | |    +--Remember up to 10000 lines in each register
"           | |    |      +--Remember up to 1MB in each register
"           | |    |      |     +--Remember last 1000 search patterns
"           | |    |      |     |     +---Remember last 1000 commands
"           | |    |      |     |     |
"           v v    v      v     v     v
set viminfo=h,'100,<10000,s1000,/1000,:1000,!

" Spelling highlights. Use underline in term to prevent cursorline highlights
" from interfering
if !has("gui_running")
  hi clear SpellBad
  hi SpellBad cterm=underline ctermfg=red
  hi clear SpellCap
  hi SpellCap cterm=underline ctermfg=blue
  hi clear SpellLocal
  hi SpellLocal cterm=underline ctermfg=blue
  hi clear SpellRare
  hi SpellRare cterm=underline ctermfg=blue
endif
set spellfile=~/.vim/spellfile.add

" Smooth font on Mac OS X
set antialias

" Highlight the current line
set cursorline

" disable sounds
set noerrorbells
set visualbell
set t_vb=

" remap K to vim help
set keywordprg=":help"

" Indent is multiple of shiftwidth
set shiftround

" Writes to the unnamed register also writes to the * and + registers.
" This makes it easy to interact with the system clipboard.
if has ('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

if exists('$TMUX')
    set clipboard=
else
    set clipboard=unnamed " sync with OS clipboard
endif

" Cursor settings. This makes terminal vim sooo much nicer!
" Tmux will only forward escape sequences to the terminal if surrounded by a DCS
" sequence
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

if executable('ag')
    set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
    set grepformat=%f:%l:%c:%m
endif
" if executable('ack')
"     set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
"     set grepformat=%f:%l:%c:%m
" endif

" Status line
set laststatus=2
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

" Enable meta key
if s:is_macvim
    set macmeta
endif

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction


"===============================================================================
" Leader Mappings
"===============================================================================

" Map leader and localleader key to comma
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","
let g:maplocalleader = ","

" <Leader>1: Toggle between paste mode
nnoremap <silent> <Leader>1 :set paste!<cr>

" <Leader>s: Spell checking shortcuts
nnoremap <Leader>ss :setlocal spell!<cr>
nnoremap <Leader>sj ]s
nnoremap <Leader>sk [s
nnoremap <Leader>sa zg]s
nnoremap <Leader>sd 1z=
nnoremap <Leader>sf z=

" <Leader>d: Delete the current buffer
nnoremap <unique> <Leader>d :bdelete<CR>

" VimFiler
nnoremap <unique> <Leader>e :VimFilerExplorer<CR>
nnoremap <unique> <Leader>t :VimFiler<CR>

" Tagbar
nnoremap <unique> <silent> <Leader>b :TagbarToggle<CR>

" JSON formatting using jq
if executable("jq")
    nnoremap <unique> <Leader>q :%!jq .<CR>
    nnoremap <unique> <Leader>Q :%!jq . -c<CR>
endif

" Ag
nnoremap <unique> <Leader>ag :Ag!<CR>

" Eclim
autocmd FileType java nnoremap <Leader>ji :JavaImport<CR>
autocmd FileType java nnoremap <Leader>jio :JavaImportOrganize<CR>
autocmd FileType java nnoremap <Leader>jr :JavaSearch -p <C-R><C-W> -x references<CR>
autocmd FileType java nnoremap <Leader>ju :JUnit<CR>


"===============================================================================
" Normal Mode Key Mappings
"===============================================================================

" gp to visually select pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" f: Find. Also support repeating with .
nnoremap <Plug>OriginalSemicolon ;
nnoremap <silent> f :<C-u>call repeat#set("\<lt>Plug>OriginalSemicolon")<CR>f
nnoremap <silent> t :<C-u>call repeat#set("\<lt>Plug>OriginalSemicolon")<CR>t
nnoremap <silent> F :<C-u>call repeat#set("\<lt>Plug>OriginalSemicolon")<CR>F
nnoremap <silent> T :<C-u>call repeat#set("\<lt>Plug>OriginalSemicolon")<CR>T

" ;: Command mode
nnoremap ; :
" nnoremap : ;

" c: Change into the blackhole register to not clobber the last yank
nnoremap c "_c

" d: Delete into the blackhole register to not clobber the last yank
" nnoremap d "_d

" dd: I use this often to yank a single line, retain its original behavior
nnoremap dd dd

" Tab: Go to matching element
nnoremap <Tab> %

"Make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>

" Use \v (magic) by default
nnoremap / /\v
vnoremap / /\v


"===============================================================================
" Insert Mode Key Mappings
"===============================================================================

" Clear highlight and redraw
inoremap <C-L> <C-O>:nohls<CR>

" Map jk -> escape
inoremap jk <esc>

" Ctrl-w: Delete previous word, create undo point
inoremap <C-w> <c-g>u<c-w>

" Ctrl-e: Go to end of line
inoremap <c-e> <esc>A

" Ctrl-a: Go to begin of line
inoremap <c-a> <esc>I

" Ctrl-h: Move word left
inoremap <c-h> <c-o>b

" Ctrl-j: Move cursor up
inoremap <expr> <c-j> pumvisible() ? "\<C-e>\<Down>" : "\<Down>"

" Ctrl-k: Move cursor up
inoremap <expr> <c-k> pumvisible() ? "\<C-e>\<Up>" : "\<Up>"

" Ctrl-l: Move word right
inoremap <c-l> <c-o>w


"===============================================================================
" Visual Mode Key Mappings
"===============================================================================
" When shifting, retain selection over multiple shifts...
vmap <expr> > KeepVisualSelection(">")
vmap <expr> < KeepVisualSelection("<")

function! KeepVisualSelection(cmd)
    set nosmartindent
    if mode() ==# "V"
        return a:cmd . ":set smartindent\<CR>gv"
    else
        return a:cmd . ":set smartindent\<CR>"
    endif
endfunction


"===============================================================================
" Command Mode Key Mappings
"===============================================================================
cmap w!! w !sudo tee % >/dev/null

"======[ Show help files in a new tab, plus add a shortcut for helpg ]======
"Only apply to .txt files...
augroup HelpInTabs
    autocmd!
    autocmd BufEnter  *.txt   call HelpInNewTab()
augroup END

"Only apply to help files...
function! HelpInNewTab ()
    if &buftype == 'help'
        "Convert the help window to a tab...
        execute "normal \<C-W>T"
    endif
endfunction

"Simulate a regular cmap, but only if the expansion starts at column 1...
function! CommandExpandAtCol1 (from, to)
    if strlen(getcmdline()) || getcmdtype() != ':'
        return a:from
    else
        return a:to
    endif
endfunction

"Expand hh -> helpg...
cmap <expr> hh CommandExpandAtCol1('hh','helpg ')


"===============================================================================
" Matchit
"===============================================================================
runtime macros/matchit.vim

" Match angle brackets...
set matchpairs+=<:>,«:»

" Match double-angles, XML tags and Perl keywords...
let TO = ':'
let OR = ','
let b:match_words =
\
\                          '<<' .TO. '>>'
\
\.OR.     '<\@<=\(\w\+\)[^>]*>' .TO. '<\@<=/\1>'
\
\.OR. '\<if\>' .TO. '\<elsif\>' .TO. '\<else\>'

" Engage debugging mode to overcome bug in matchpairs matching...
let b:match_debug = 1


"===============================================================================
" Font
"===============================================================================
if s:is_macvim
    set guifont=Inconsolata:h14
    set transparency=2
else
    set guifont=Inconsolata\ 13
endif


"===============================================================================
" Auto Commands
"===============================================================================
set omnifunc=syntaxcomplete#Complete
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ant setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType clojure setlocal omnifunc=vimclojure#OmniCompletion

autocmd FileType ruby setlocal sts=2 sw=2 ts=2 et
autocmd FileType xml setlocal sts=2 sw=2 ts=2 et
autocmd FileType ant setlocal sts=2 sw=2 ts=2 et
autocmd FileType html setlocal sts=2 sw=2 ts=2 et
autocmd FileType javascript setlocal sts=2 sw=2 ts=2 et
autocmd FileType json setlocal syntax=javascript

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

augroup quickfix_mappings
    autocmd!
    autocmd BufReadPost quickfix nnoremap <silent> <buffer> h  <C-W><CR><C-w>K
    autocmd BufReadPost quickfix nnoremap <silent> <buffer> H  <C-W><CR><C-w>K<C-w>b
    autocmd BufReadPost quickfix nnoremap <silent> <buffer> o  <CR>
    autocmd BufReadPost quickfix nnoremap <silent> <buffer> t  <C-w><CR><C-w>T
    autocmd BufReadPost quickfix nnoremap <silent> <buffer> T  <C-w><CR><C-w>TgT<C-W><C-W>
    autocmd BufReadPost quickfix nnoremap <silent> <buffer> v  <C-w><CR><C-w>H<C-W>b<C-W>J<C-W>t
    autocmd BufReadPost quickfix nnoremap <silent> <buffer> e  <CR><C-w><C-w>:cclose<CR>
    autocmd BufReadPost quickfix nnoremap <silent> <buffer> go <CR>:copen<CR>
    autocmd BufReadPost quickfix nnoremap <silent> <buffer> q  :lclose<CR>
augroup END


"===============================================================================
" Tagbar
"===============================================================================
if filereadable("/usr/local/bin/ctags")
    let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
endif

let g:tagbar_autofocus = 1


"===============================================================================
" Vim-Clojure Static
"===============================================================================
let g:clojure_align_multiline_strings = 0


"===============================================================================
" Neocomplete
"===============================================================================
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#enable_refresh_always = 1
let g:neocomplete#use_vimproc = 1
let g:neocomplete#min_keyword_length = 3
let g:neocomplete#enable_omni_fallback = 1

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " return neocomplete#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()
"inoremap <expr><C-e> neocomplete#cancel_popup()
inoremap <expr><C-g> neocomplete#undo_completion()
"inoremap <expr><C-l> neocomplete#complete_common_string()

if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.java = '\%(\h\w*\|)\)\.\w*'

" For smart TAB completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
       \ <SID>check_back_space() ? "\<TAB>" :
       \ neocomplete#start_manual_complete()
function! s:check_back_space()
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction


"===============================================================================
" Unite
"===============================================================================

" Use the fuzzy matcher for everything
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" sort buffers by number
call unite#custom#source('buffer', 'sorters', 'sorter_reverse')

" Use the rank sorter for everything
" call unite#filters#sorter_default#use(['sorter_rank'])
call unite#filters#sorter_default#use(['sorter_selecta'])

" Set up some custom ignores
call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ '\.hg/',
      \ '\.svn/',
      \ '\.cabal-sandbox/',
      \ '\.gradle/',
      \ '\.pyc',
      \ '\.class',
      \ '\.repl',
      \ 'target/',
      \ 'dist/',
      \ 'bin/',
      \ 'build/',
      \ 'git5/.*/review/',
      \ 'google/obj/',
      \ ], '\|'))

call unite#custom#source('file,file/new,buffer,file_rec,file_mru,line,outline,tab,bookmark,directory,grep',
                       \ 'matchers', 'matcher_fuzzy')

call unite#custom#profile('default', 'context', {
\   'start_insert': 1,
\   'prompt': '» ',
\   'marked_icon':'✓',
\   'short_source_names': 1,
\   'update_time': 200,
\   'cursor_line_highlight': 'CursorLine',
\ })

" let g:unite_source_rec_max_cache_files = 5000
let g:unite_source_rec_max_cache_files = 0
call unite#custom#source('file_rec,file_rec/async,file_mru,file,buffer,grep,directory',
                       \ 'max_candidates', 0)

" Enable history yank source
let g:unite_source_history_yank_enable = 1

" Open in bottom right
let g:unite_split_rule = "botright"

let g:unite_source_file_mru_long_limit = 5000
" let g:unite_abbr_highlight = 'TabLine'

let g:neomru#file_mru_limit = 100

let g:unite_source_file_mru_filename_format = ':~:.'
let g:unite_source_file_mru_time_format = '(%A %e %b, %T) '

let g:unite_enable_smart_case = 1

let g:unite_source_rec_async_command='ag --nocolor --follow --nogroup --skip-vcs-ignores ' .
            \ '--ignore ".hg" --ignore ".svn" --ignore ".git" --ignore ".bzr" --ignore ".cabal-sandbox" ' .
            \ '--ignore ".repl" --ignore "dist" --ignore "target" --ignore "bin" --ignore "build" ' .
            \ '--ignore ".gradle" --hidden -g ""'

let g:unite_source_grep_max_candidates = 0
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--smart-case --follow --nogroup --nocolor --line-numbers --skip-vcs-ignores --hidden'
let g:unite_source_grep_recursive_opt = ''

let g:unite_matcher_fuzzy_max_input_length = 40

" Map space to the prefix for Unite
nnoremap [unite] <Nop>
nmap <space> [unite]

" General fuzzy search
nnoremap <silent> [unite]<space> :<C-u>Unite
            \ -toggle -auto-resize
            \ -buffer-name=mixed file_rec/async buffer file_mru bookmark<CR><C-u>

" Quick registers
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>

" Quick yank history
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<CR>

" Quick outline
nnoremap <silent> [unite]o :<C-u>Unite -buffer-name=outline -vertical outline<CR>

" Quick sessions (projects)
nnoremap <silent> [unite]p :<C-u>Unite -buffer-name=sessions session<CR>

" Quick sources
nnoremap <silent> [unite]a :<C-u>Unite -buffer-name=sources source<CR>

nnoremap <silent> [unite]s
        \ :<C-u>Unite -buffer-name=files -no-split
        \ jump_point file_point buffer_tab
        \ file_rec/async:! file_rec/git file file/new<CR>

" Quickly switch lcd
nnoremap <silent> [unite]d
            \ :<C-u>Unite -buffer-name=change-cwd -default-action=cd directory directory_mru<CR>

" Quick file search
nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files
            \ -toggle -auto-resize
            \ file_rec/async:! file/new<CR>

" Quick grep from cwd
nnoremap <silent> [unite]g :<C-u>Unite -buffer-name=grep grep:.<CR>

" Quick help
nnoremap <silent> [unite]h :<C-u>Unite -buffer-name=help help<CR>

" Quick git search
nnoremap <silent> [unite]i :<C-u>Unite -buffer-name=git
            \ -toggle -auto-resize
            \ file_rec/git:--cached:--others:--exclude-standard<CR>

" Quick line using the word under cursor
nnoremap <silent> [unite]l :<C-u>Unite -buffer-name=line_search line<CR>

" Quick line using the word under cursor
nnoremap <silent> [unite]w :<C-u>UniteWithCursorWord -buffer-name=search_file line<CR>

" Quick MRU search
nnoremap <silent> [unite]m :<C-u>Unite -buffer-name=mru file_mru buffer<CR>

" Quick find
nnoremap <silent> [unite]n :<C-u>Unite -buffer-name=find find:.<CR>

" Quick commands
nnoremap <silent> [unite]c :<C-u>Unite -buffer-name=commands command<CR>

" Quick bookmarks
nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=buffer_bookmarks buffer bookmark<CR>

" Quick tab
nnoremap <silent> [unite]t :<C-u>Unite -buffer-name=tab -auto-resize tab<CR>

" Quick commands
nnoremap <silent> [unite]; :<C-u>Unite -buffer-name=history history/command command<CR>

" Custom Unite settings
autocmd MyAutoCmd FileType unite call s:unite_settings()
function! s:unite_settings()
    nmap <buffer> <ESC> <Plug>(unite_exit)
    imap <buffer> <ESC> <Plug>(unite_exit)
    " imap <buffer> <c-j> <Plug>(unite_select_next_line)
    imap <buffer> <c-j> <Plug>(unite_insert_leave)
    nmap <buffer> <c-j> <Plug>(unite_loop_cursor_down)
    nmap <buffer> <c-k> <Plug>(unite_loop_cursor_up)
    nmap <buffer> <C-p> <Plug>(unite_toggle_auto_preview)
    imap <buffer> <c-a> <Plug>(unite_choose_action)
    imap <buffer> <TAB> <Plug>(unite_select_next_line)
    imap <buffer> jj    <Plug>(unite_insert_leave)
    imap <buffer> <C-w> <Plug>(unite_delete_backward_word)
    imap <buffer> <C-u> <Plug>(unite_delete_backward_path)
    imap <buffer> '     <Plug>(unite_quick_match_default_action)
    nmap <buffer> '     <Plug>(unite_quick_match_default_action)
    imap <buffer><expr> x
            \ unite#smart_map('x', "\<Plug>(unite_quick_match_choose_action)")
    nmap <buffer> <C-r> <Plug>(unite_redraw)
    imap <buffer> <C-r> <Plug>(unite_redraw)
    inoremap <silent><buffer><expr> <C-s> unite#do_action('split')
    nnoremap <silent><buffer><expr> <C-s> unite#do_action('split')
    inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
    nnoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
    nnoremap <silent><buffer><expr> l
            \ unite#smart_map('l', unite#do_action('default'))

    let unite = unite#get_current_unite()
    if unite.buffer_name =~# '^search'
        nnoremap <silent><buffer><expr> r     unite#do_action('replace')
    else
        nnoremap <silent><buffer><expr> r     unite#do_action('rename')
    endif

    nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
    nnoremap <buffer><expr> S      unite#mappings#set_current_filters(
            \ empty(unite#mappings#get_current_filters()) ?
            \ ['sorter_reverse'] : [])

    " Using Ctrl-\ to trigger outline, so close it using the same keystroke
    if unite.buffer_name =~# '^outline'
        imap <buffer> <C-\> <Plug>(unite_exit)
    endif

    " Using Ctrl-/ to trigger line, close it using same keystroke
    if unite.buffer_name =~# '^search_file'
        imap <buffer> <C-_> <Plug>(unite_exit)
    endif
endfunction


"===============================================================================
" NERDCommenter
"===============================================================================
" Always leave a space between the comment character and the comment
let NERDSpaceDelims=1


"===============================================================================
" Syntastic
"===============================================================================
let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'


"===============================================================================
" Supertab
"===============================================================================
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<C-n>"
let g:SuperTabCrMapping = 0


"===============================================================================
" Airline
"===============================================================================
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline_symbols = {}
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.paste = 'ρ'
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_powerline_fonts=0


"===============================================================================
" vim-sneak
"===============================================================================
let g:sneak#streak = 1


"===============================================================================
" vimfiler
"===============================================================================
" Edit file by tabedit
let g:vimfiler_as_default_explorer = 1

" Enable file operation commands.
let g:vimfiler_safe_mode_by_default = 0

let g:vimfiler_enable_auto_cd = 1

" Like Textmate icons.
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'



"===============================================================================
" Dragvisuals
"===============================================================================
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()


"===============================================================================
" UltiSnips
"===============================================================================
let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsExpandTrigger="<C-CR>"


"===============================================================================
" Ag
"===============================================================================
let g:agprg="ag --column --smart-case --follow"
let g:aghighlight=1
let g:ag_mapping_message=0


"===============================================================================
" Eclim
"===============================================================================
let g:EclimCompletionMethod = 'omnifunc'
let g:EclimJavaSearchSingleResult = 'tabnew'
let g:EclimLocateFileFuzzy = 1
let g:EclimTempFilesEnable = 0
command -range -nargs=* Google call eclim#web#SearchEngine(
  \ 'http://www.google.com/search?q=<query>', <q-args>, <line1>, <line2>)
autocmd FileType java nnoremap <silent><buffer><CR> :JavaSearchContext<CR>


"===============================================================================
" Haskell
"===============================================================================
if neobundle#is_sourced('neco-ghc')
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
    let g:necoghc_enable_detailed_browse = 1
endif
autocmd FileType haskell compiler cabal
let g:haskell_conceal = 0
let g:haskell_conceal_enumerations = 0


"===============================================================================
" delimitMate
"===============================================================================
au FileType haskell,clojure,java let b:delimitMate_matchpairs = "(:),[:],{:}"


"===============================================================================
" Vimshell
"===============================================================================
" let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
" "let g:vimshell_right_prompt = 'vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'

if has('win32') || has('win64')
    " Display user name on Windows.
    let g:vimshell_prompt = $USERNAME."% "
else
    " Display user name on Linux.
    let g:vimshell_prompt = $USER."% "
endif

" Initialize execute file list.
let g:vimshell_execute_file_list = {}
call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java', 'vim')
let g:vimshell_execute_file_list['rb'] = 'ruby'
let g:vimshell_execute_file_list['pl'] = 'perl'
let g:vimshell_execute_file_list['py'] = 'python'
call vimshell#set_execute_file('html,xhtml', 'gexe firefox')

autocmd FileType vimshell
\ call vimshell#altercmd#define('g', 'git')
\| call vimshell#altercmd#define('i', 'iexe')
\| call vimshell#altercmd#define('l', 'll')
\| call vimshell#altercmd#define('ll', 'ls -l')
\| call vimshell#hook#add('chpwd', 'my_chpwd', 'MyChpwd')

function! MyChpwd(args, context)
    call vimshell#execute('ls')
endfunction

autocmd FileType int-* call s:interactive_settings()
function! s:interactive_settings()
endfunction


"===============================================================================
" Misc function
"===============================================================================
function! DeleteEmptyBuffers()
    let [i, n; empty] = [1, bufnr('$')]
    while i <= n
        if bufexists(i) && bufname(i) == ''
            call add(empty, i)
        endif
        let i += 1
    endwhile
    if len(empty) > 0
        exe 'bdelete' join(empty)
    endif
endfunction


"===============================================================================
" Colour Scheme
"===============================================================================
colorscheme vividchalk

if has('gui_running')
    " let g:airline_theme="gotham"
    " colorscheme gotham
else
    " colorscheme gotham256

    " Compatibility for Terminal
    let g:solarized_termtrans=1

    " Make Solarized use 256 colors for Terminal support
    let g:solarized_termcolors=256
endif
