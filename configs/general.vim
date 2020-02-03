"  _   __
" | | / /
" | |/ / _   _  ___ ____
" |    \| | | |/ _ \_  /  Author: Kyoz
" | |\  \ |_| | (_) / /   Github: github.com/banminkyoz
" \_| \_/\__, |\___/___|  Email : banminkyoz@gmail.com
"         __/ |
"        |___/

" PYTHON PROVIDERS {{{

if has('macunix')
  " OSX
  let g:python3_host_prog = '/usr/local/bin/python3' "---------- Set python 3 provider
  let g:python_host_prog = '/usr/local/bin/python2' "-------------- Set python 2 provider
elseif has('unix')
  " Ubuntu
  let g:python3_host_prog = '/usr/bin/python3' "---------- Set python 3 provider
  let g:python_host_prog = '/usr/bin/python' "-------------- Set python 2 provider
elseif has('win32') || has('win64')
  " Window
endif

" }}}

" INTERFACE {{{

:set guioptions-=m "-------------------------------------------- Remove menu bar
:set guioptions-=T "--------------------------------------------- Remove toolbar
:set guioptions-=r "------------------------------- Remove right-hand scroll bar
:set guioptions-=L "-------------------------------- Remove left-hand scroll bar

" }}}

" DISPLAY {{{

set encoding=utf8
set nowrap "---------------------------------- do not automatically wrap on load
set colorcolumn=80 "---------------------------------------- 80 line column show
set nospell "-------------------------------------------------- Disable spelling
set formatoptions-=t "--------------- Do not automatically wrap text when typing
set listchars=tab:\|\ ,trail:▫
set formatoptions=tcqronj "-------------------- Set vims text formatting options
set title "-------------------------------------- Let vim set the terminal title
set updatetime=500 "-------------------------------- Redraw the status bar often
set list "--------------------------------------------- Show trailing whitespace
set listchars=tab:•\ ,trail:•,extends:»,precedes:« "-- Unprintable chars mapping
set showcmd	"--------------------------------------- Display incomplete commands
set termencoding=utf-8 "------------------------------------------- Always utf-8
set fileencoding=utf-8
set hid "---------------------------------- Buffer becomes hidden when abandoned
set shortmess+=c
set cmdheight=1 "--------------------------- Just need one line for command line
set laststatus=2 "-------------------------------------- Always show status line
set showtabline=2 "----------------------------------------- Always show tabline
set noshowmode "--------------------------- Hide default mode text (e.g. INSERT)
set display+=lastline "--------------------- As must as possible of the lastline
set signcolumn=yes "---------------------------------- Always open gutter column
set previewheight=3 "------------------------------------ Smaller preview height

" Disable for performance
" set number "------------------------------------------------- Show line number
" set ruler "---------- Line number, column's number, virtual column's number...
" set relativenumber "------------------------------------- Show relative number
" set cursorline "-------------------- Highlight the current line for the cursor

" }}}

" FILE TYPES {{{

augroup language_react
    autocmd!
    autocmd bufnewfile,bufread *.tsx set filetype=javascriptreact
augroup END

" }}}

" SYNTAX {{{

syntax on "---------------------------------------------- Enable Syntax for Code
syntax enable
set foldmethod=manual "---------------------------------- Support fold by indent

" }}}

" COLOR SOLARIZE {{{

set termguicolors "--------------------------------------- True color for neovim

if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" }}}

" FILE, FILE'S TYPES {{{

set autoread "---------------------------------------- Auto reloaded Edited File
set noswapfile "------------------------------------------ Dont create wrap file
set nobackup "------------------------------------------------- Dont save backup
filetype plugin on "--------------------------------------------- Turn on plugin
let g:jsx_ext_required = 1 "------------------------- Dont detect js file as jsx

" }}}

" TYPINGS {{{

set backspace=indent,eol,start "----------------- Allow backspace in insert mode

" }}}

" TAB, INDENT {{{

set tabstop=2 "---------------------------------------------- 2 spaces for 1 tab
set softtabstop=2
set shiftwidth=2
set expandtab "------------------------------------------ Add tab in insert mode
set smarttab
filetype indent on "------------------------------------- Turn on default indent
set autoindent
set smartindent

" }}}

" SEARCH {{{

set hlsearch "------------------------------------------ Highlight search result
set incsearch "------------------------------------------ Allow Insert higtlight

" }}}

" FORMAT {{{

set nrformats-=octal "----------------------------------- Format number as octal

" }}}

" UNDO {{{

set undolevels=100 "------------------------------- Default is 1000 -> Too large
set undoreload=1000 "----------------------------- Default is 10000 -> Too large
set undodir=~/.config/nvim/undodir "--------------- Default folder for undo step

" }}}

" FOLDING {{{

augroup folding_vim
  autocmd!
  autocmd FileType vim        setlocal foldmethod=marker
  autocmd FileType snippets   setlocal foldmethod=marker
augroup END

" }}}

" ENABLE MOUSE {{{

if has('mouse')
    set mouse=a "----------------------------- Allow use mouse, possible in nvim
endif

" }}}

" ASF {{{

nnoremap n nzz
nnoremap N Nzz

nnoremap <tab><tab> <c-^> " -------------------Switch between the last two files
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//gc<Left><Left><Left> " replace word under
vnoremap <Leader>r y :%s/<C-r>"//gc<Left><Left><Left> " cursor, globally, with c
map <F7> mzgg=G`z " --------re-indent file and jump back to where the cursor was

nnoremap <silent> <leader>zi :setlocal foldmethod=indent<CR> " fold file based on indent

nnoremap <silent> <F9> :windo diffthis<CR>

nnoremap <Leader>rn :!mv <C-R>=expand("%")<CR> " ------------rename current file
nnoremap <Leader><Leader> zz " --------------------------------Center the screen
nnoremap Y y$ " ------------------------------------------------Act like D and C
vnoremap <leader>cc "*y " ------------------------------------Copy from register
map <leader>vv "*p " ----------------------------------------Paste from register
nnoremap <silent> <Leader>= gg=G

nnoremap <silent> <Leader>q :Bdelete<CR>
nnoremap <silent> <Leader>+ :vertical resize +20<CR>
nnoremap <silent> <Leader>- :vertical resize -20<CR>
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
noremap <C-j> <C-w>j
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-s> :w<CR>
noremap <C-u> :e ++ff=dos<CR>
nnoremap <silent> L :call MyNext()<CR>
nnoremap <silent> H :call MyPrev()<CR>

cmap w!! w !sudo tee > /dev/null % " ------When I forgot to start vim using sudo
nnoremap ,w :call SwapSplitResizeShortcuts()<CR> " -------Resizing split windows
imap jk <Esc> " ------------------------------------------Escape for insert mode
map 0 ^ " ---------------------------------------------Firs char in current line

noremap <Leader>d yyp " ----------------------------------duplicate current line

nnoremap <A-j> :m .+1<CR>== " ----------------------------------------Move lines
nnoremap <A-k> :m .-2<CR>== " ----------------------------------------Move lines
inoremap <A-j> <Esc>:m .+1<CR>==gi " ---------------------------------Move lines
inoremap <A-k> <Esc>:m .-2<CR>==gi " ---------------------------------Move lines
vnoremap <A-j> :m '>+1<CR>gv=gv " ------------------------------------Move lines
vnoremap <A-k> :m '<-2<CR>gv=gv " ------------------------------------Move lines

nnoremap <Leader>p g; " ----Jump back to your last edit (do this in normal mode)
nnoremap <Leader>n g, " ----Jump back to your last edit (do this in normal mode)

nnoremap <Leader>o ^o	" -Jump back to the position you were last (Out),jump back
nnoremap <Leader>i ^i	" ---Jump back to the position you were last (In), forward

nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR> " ------Clear search highlight

vmap < <gv " ---------------Vmap for maintain Visual Mode after shifting > and <
vmap > >gv " ---------------Vmap for maintain Visual Mode after shifting > and <

nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR> " -Change to current working directory

map <Leader>v :e $MYVIMRC<CR> " -----------------------------------Open init.vim

" MyNext() and MyPrev(): Movement between tabs OR buffers
function! MyNext()
    if exists( '*tabpagenr' ) && tabpagenr('$') != 1
        " Tab support && tabs open
        normal gt
    else
        " No tab support, or no tabs open
        execute ":bnext"
    endif
endfunction
function! MyPrev()
    if exists( '*tabpagenr' ) && tabpagenr('$') != '1'
        " Tab support && tabs open
        normal gT
    else
        " No tab support, or no tabs open
        execute ":bprev"
    endif
endfunction

" SwapSplitResizeShortcuts(): Resizing split windows
if !exists( 'g:resizeshortcuts' )
    let g:resizeshortcuts = 'horizontal'
    nnoremap _ <C-w>-
    nnoremap + <C-w>+
endif

function! SwapSplitResizeShortcuts()
    if g:resizeshortcuts == 'horizontal'
        let g:resizeshortcuts = 'vertical'
        nnoremap _ <C-w><
        nnoremap + <C-w>>
        echo "Vertical split-resizing shortcut mode."
    else
        let g:resizeshortcuts = 'horizontal'
        nnoremap _ <C-w>-
        nnoremap + <C-w>+
        echo "Horizontal split-resizing shortcut mode."
    endif
endfunction


let g:ackpreview = 0
let g:ack_autofold_results = 0
let g:ackhighlight = 1

cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space><C-R><C-W>
nnoremap <Leader>ff 0yi":Ack!<Space>'<C-R>" = fields' --py<CR> " Where the field was defined
nnoremap <Leader>fm 0yi":Ack!<Space>"def <C-R>"" --py<CR> "Where de method was defined
nnoremap <Leader>mn yit:Ack!<Space>"_name = '<C-R>"'" --py<CR> "Where de module was defined
vnoremap <Leader>mn y:Ack!<Space>"_name = '<C-R>"'" --py<CR> "Where de module was defined
vnoremap <Leader>ai y:Ack!<Space>"_inherit = '<C-R>"'" --py<CR> "Where de module was inherited
nnoremap <Leader>mi yit:Ack!<Space>"_inherit = '<C-R>"'" --py<CR> "Where de module was inherited
nnoremap <Leader>ap :Ack!<Space><C-R><C-W> --py<CR> "In all Python files
nnoremap <Leader>ax :Ack!<Space><C-R><C-W> --xml<CR> "In all XML files

" }}}
