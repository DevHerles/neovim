" WINDOW {{{

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

nnoremap <silent> <Leader>q :bdelete<CR> " ------------Delete the current buffer
nnoremap <silent> <Leader>Q :bufdo! bd<CR> " Deletes all except with unwritten changes
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

highlight BadWhitespace ctermbg=red guibg=default

autocmd InsertEnter * highlight CursorLine guibg=#000000 guifg=fg
autocmd InsertLeave * highlight CursorLine guibg=#000000 guifg=fg

autocmd InsertEnter * highlight CursorColumn ctermfg=White ctermbg=Yellow cterm=bold guifg=white guibg=black gui=bold
autocmd InsertLeave * highlight CursorColumn ctermfg=Black ctermbg=Yellow cterm=bold guifg=Black guibg=black gui=NONE

" }}}

" ACK {{{

let g:ackpreview = 0
let g:ack_autofold_results = 0
let g:ackhighlight = 1

cnoreabbrev Ack Ack!
cnoreabbrev ack Ack!
nnoremap <Leader>a :Ack!<Space><C-R><C-W>
nnoremap <Leader>ff 0yi":Ack!<Space>'<C-R>" = fields' --py<CR> " ----Where the field was defined
nnoremap <Leader>fm 0yi":Ack!<Space>"def <C-R>"" --py<CR> " ---------Where de method was defined
nnoremap <Leader>mn yit:Ack!<Space>"_name = '<C-R>"'" --py<CR> " ----Where de module was defined
vnoremap <Leader>mn y:Ack!<Space>"_name = '<C-R>"'" --py<CR> " ------Where de module was defined
vnoremap <Leader>ai y:Ack!<Space>"_inherit = '<C-R>"'" --py<CR> " -Where de module was inherited
nnoremap <Leader>mi yit:Ack!<Space>"_inherit = '<C-R>"'" --py<CR> "Where de module was inherited
nnoremap <Leader>ap :Ack!<Space><C-R><C-W> --py<CR> " -----------------------In all Python files
nnoremap <Leader>ax :Ack!<Space><C-R><C-W> --xml<CR> " -------------------------In all XML files

" }}}

" RIPGREP {{{

if executable('rg')
  "" Set default grep to ripgrep
  set grepprg=rg\ --vimgrep

  "" Set default ripgrep configs for fzf
  "# --files: List files that would be searched but do not search
  "# --no-ignore: Do not respect .gitignore, etc...
  "# --hidden: Search hidden files and folders
  "# --follow: Follow symlinks
  "# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
  let $FZF_DEFAULT_COMMAND ='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

  "" Define custom :Find command to leverage rg
  " --column: Show column number
  " --line-number: Show line number
  " --no-heading: Do not show file headings in results
  " --fixed-strings: Search term as a literal string
  " --ignore-case: Case insensitive search
  " --no-ignore: Do not respect .gitignore, etc...
  " --hidden: Search hidden files and folders
  " --follow: Follow symlinks
  " --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
  " --color: Search color options
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
endif

" }}}

" RANGER {{{

noremap <Leader>t :RangerCurrentDirectory<CR>
noremap <Leader>f :FZF<CR>

" }}}

