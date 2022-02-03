" ### #  # ### ###
"  #  ## #  #   #
"  #  # ##  #   #
" ### #  # ###  #
"
" Cheatsheet:
" <F5> Undotree
"
" <C-P>: CtrlPMixed
" <C-F>: Change modes
"
" gbb/gB: buffer
" gbv:    vsplit buffer
" gbt:    tabnew buffer
" <C-W><S-T>: move current buffer to new tab
"
" gcc: comment line
" gcgc: uncomment lines
" 
" [Visual] + <Right Mouse>: Find
" [Visual] + <Middle Mouse>: Copy
"
" TODO:
" . ctrlp is useless? i only need MRU?
" . better broken keyboard imap
" . subtler indent guide color
" . fix double tab autocompletion
" 

" -------- PLUGINS
call plug#begin('~/.config/nvim/plugged')
Plug 'tomasr/molokai'
Plug 'jhlgns/naysayer88.vim'
Plug 'uiiaoo/java-syntax.vim'
Plug 'bfrg/vim-cpp-modern'
Plug 'ap/vim-css-color'

" Plug 'itchyny/lightline.vim'
Plug 'mbbill/undotree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ajh17/vimcompletesme'

Plug 'nathanaelkane/vim-indent-guides'
Plug 'unblevable/quick-scope'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

" SLOW!
" Plug 'valloric/matchtagalways'

" Linux only
" Plug 'weakish/rcshell.vim'
call plug#end()

" lightline
" set noshowmode
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'separator': { 'left': '▓▒░', 'right': '░▒▓' },
    \ 'subseparator': { 'left': '', 'right': '' },
    \ 'active': {
    \   'left': [
    \             [ 'filename', 'modified' ],
    \             [ 'myline' ],
    \             [ 'filetype', 'readonly' ]
    \           ],
    \  'right': [
    \             [],
    \             [],
    \             []
    \           ]
    \ },
    \ 'component': {
    \ },
    \ 'component_function': {
    \   'filename': 'LightlineFilename',
    \   'modified': 'LightlineModified',
    \   'readonly': 'LightlineReadonly',
    \   'myline': 'LightlineLine',
    \ }
    \ }
"\ 'separator': { 'left': '▓▒░', 'right': '░▒▓' },
"\             [ 'lineinfo' ],
"\             [ 'percent' ],
"\             [ 'filetype' ]

function! LightlineFilename()
  let fname = expand('%:f')
  return fname ==# 'undotree_2' ? 'undotree' :
       \ fname ==# 'diffpanel_3' ? 'diffpanel' :
       \ fname !=# '' ? fname : '[no name]'
endfunction

function! LightlineModified()
  return &ft =~# 'help' ? '' : &modified ? '[+] ' : &modifiable ? '' : '[-] '
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? 'readonly' : ''
endfunction

function! LightlineLine()
  return ' ln ' . line('.') . '.' . line('$')
endfunction

function! LightlineFiletype()
  return &ft !=# '' ? &ft : 'no ft'
endfunction

" undotree
nnoremap <silent> <F5> :UndotreeToggle<CR>
let g:undotree_SplitWidth = 33

" ctrlp
let g:ctrlp_cmd = 'CtrlPMRUFiles'
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_types = ['mru', 'mixed']
let g:ctrlp_extensions = ['mixed']

" indent guides
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size  = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#293739
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#232526

" -------- CONFIGURATIONS
set scrolloff=3
set sidescrolloff=5

set statusline=\ %-{LightlineFilename()}\ %-{LightlineModified()}\|%-{LightlineLine()}\ \|\ %-{LightlineFiletype()}\ %-{LightlineReadonly()}
set autochdir

set tabstop=4
set shiftwidth=4
set expandtab

set splitright

set autoindent
set smartindent

colorscheme naysayer88
set guifont=Consolas:h10
" hi link javaIdentifier NONE
" hi link javaDebug Conditional

" wrap
set whichwrap+=<,>,h,l,[,]

set wildcharm=<C-Z>
cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>"
cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>"
cnoremap <expr> <left> wildmenumode() ? "\<up>" : "\<left>"
cnoremap <expr> <right> wildmenumode() ? " \<bs>\<C-Z>" : "\<right>"

set switchbuf=usetab
set hidden

filetype plugin indent on

autocmd FileType c,cpp setlocal commentstring=//%s

" COMPILING

nnoremap <M-m> :make<CR>
autocmd FileType c,cpp setlocal makeprg=build
autocmd FileType vim nnoremap <buffer> <M-m> :So<CR>

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <silent> <M-n> :call ToggleQuickFix()<CR>
nnoremap <silent> <M-,> :cbefore<CR>
nnoremap <silent> <M-.> :cafter<CR>
nnoremap <silent> <M-<> :cprevious<CR>
nnoremap <silent> <M->> :cnext<CR>

" -------- MAPPINGS
tnoremap <S-Escape> <C-\><C-N>

" NAVIGATION
" start of the line
noremap 0 ^
noremap ^ 0
" WARNING: i don't use text object motions(?)
noremap ) 0

" ctrl u and d are too hard to follow
" because it changes your view
nnoremap K 10k
vnoremap K 10k
nnoremap J 10j
vnoremap J 10j
" nnoremap K {
" vnoremap K {
" nnoremap J }
" vnoremap J }

nnoremap <M-k> <C-u>
vnoremap <M-k> <C-u>
nnoremap <M-j> <C-d>
vnoremap <M-j> <C-d>

" movement
nnoremap H b
nnoremap L w
vnoremap H b
vnoremap L w

nnoremap <M-h> B
nnoremap <M-l> W
vnoremap <M-h> B
vnoremap <M-l> W

inoremap <M-h> <C-Left>
inoremap <M-l> <C-Right>

" quick window switch
" nunmap w
" nunmap W
" nunmap b
" nunmap B
" nunmap e
" nunmap S
" nunmap U

function! MarkCount(count)
    execute ":normal! m" . a:count
    echo 'mark ' . a:count . ' set on line ' . line('.')
endfunction

nnoremap <silent> <Space>   :<C-u>call MarkCount(v:count)<CR>
nnoremap <silent> <S-Space> :<C-u>execute ":normal! '" . v:count<CR>
nnoremap M '

nnoremap w <C-W>w
nnoremap W <C-W>W
nnoremap <M-w> <C-W>w

" buffer
" TODO: better buffer????
nnoremap gbb :call feedkeys(':b <Tab>', 't')<CR>
nmap gB gbb
nnoremap gbv :call feedkeys(':vert sb <Tab>', 't')<CR>
nnoremap gbt :call feedkeys(':tab sb <Tab>', 't')<CR>
nnoremap <M-W> <C-^>
nnoremap b <C-^>
nmap B gbb

" file
" TODO: better file
nnoremap \ee :call feedkeys(':e %:p:h<Tab>', 't')<CR>
nmap <M-e> \ee
nnoremap \ep :e D:\programming\
nnoremap \ed :e C:\Users\user\Documents\
nnoremap \ek :e D:\sch\KULIAH\

" EDITING
" ctrl+backspace
inoremap <C-BS> <C-W>
cnoremap <C-BS> <C-W>
inoremap <C-Del> <C-o>dw
" TODO: cnoremap <C-Del>
" inoremap <C-Del> X<Esc>lbce

" delete without cut
nnoremap dD "_dd
vnoremap D "_d

" visual indentation
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

vnoremap <Space> =

vnoremap > >gv
vnoremap < <gv

" nmap <M-c> gcc
" vmap <M-c> gc
nmap U gcc
vmap U gc

" COMMANDS
command Init execute ':e C:\Users\user\AppData\Local\nvim\init.vim'
command Source execute ':source $MYVIMRC'
command! BufOnly execute '%bdelete | edit # | normal `"'

" ctrl+s saving
noremap  <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <Esc>:update<CR>gi

" yank-paste system clipboard
" TODO: do we even need P? if we don't,
" we can use it for pasting from yank register?
vmap <silent> <M-y> "+y:echom "copied"<CR>
nmap <silent> <M-p> "+p:echom "pasted"<CR>
nmap <silent> <M-P> "+P:echom "pasted"<CR>
" vnoremap <silent> \y 
" nnoremap <silent> \p 
" nnoremap <silent> \P 

" replace
nnoremap <M-r> :%s/
vnoremap <M-r> :s/
" nnoremap \R :s
" nmap <M-r> \r
" vmap <M-r> \r

nnoremap <M-f> %
" nmap <M-f> *
" nmap <M-F> #

" I almost never use Replace Mode
" So I use a more pleasant key for redo
nnoremap R <C-r>
nnoremap <C-r> R

" D deletes to the end of line, C too
" So Y should be the same imo
nnoremap Y y$

" Broken keyboard maps D:
nmap <silent> <M-v> <C-V>

" nmap <silent> <M-s> <C-S>
" vmap <silent> <M-s> <C-S>
" imap <silent> <M-s> <C-S>

nmap <silent> S <C-S>

" imap <silent> <M-n> <C-N>
" imap <silent> <M-p> <C-P>

" nmap <M-u> <C-U>
" nmap <M-d> <C-D>
" vmap <M-u> <C-U>
" vmap <M-d> <C-D>

imap <M-q> =
imap <M-p> +
imap <M-m> -
imap <M-M> _
imap <M-f> 5
imap <M-F> %
imap <M-s> 6
imap <M-S> ^

cmap <M-q> =
cmap <M-p> +
cmap <M-m> -
cmap <M-M> _
cmap <M-f> 5
cmap <M-F> %
cmap <M-s> 6
cmap <M-S> ^


" Java
autocmd BufNewFile *.java
            \ exe "normal Ipublic clas \<BS>s " . expand('%:t:r') . " {\npublic static void main(String[] args) {\nW\<BS>\n}\n}\<Esc>3G$"

" C++
nnoremap <silent> <M-b> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Acme-like Navigation
" Set mouse to normal and visual
set mouse=nv

" Disable the default right mouse function of extending selection
map <silent> <RightMouse> <Nop>
map <silent> <2-RightMouse> <Nop>
map <silent> <3-RightMouse> <Nop>
map <silent> <4-RightMouse> <Nop>
map <silent> <RightDrag> <Nop>
map <silent> <RightRelease> <Nop>

" Copy selection with middle mouse
vnoremap <silent> <MiddleMouse> "+y:echom "copied"<CR>

" Find word under the cursor then select it
nnoremap <silent> <RightMouse><RightRelease> <LeftMouse>*gn

" Find selection then select it
vnoremap <silent> <RightRelease> y/\V<C-R>=escape(@",'/\')<CR><CR>gn

" Disable highlighting with Escape
nnoremap <silent> <ESC> :noh<CR><ESC>
"nnoremap <silent> <ESC>^[ <ESC>^[

" Auto-complete filename
inoremap <silent> <C-F> <C-X><C-F>



" SENT'S INIT.VIM MANIFESTO
" 
" 1. Screw the default vim keybindings. If you have a better keybinding,
"    use it.
" 2. Screw the "vim purists". You shouldn't restrict yourself with not
"    being able to move in Insert mode just because "it's not the vim way".
"    Do things that make you the most comfortable.
" 3. Utilize Alt key. I use GUI so it shouldn't be a problem.
" 4. Make it as minimal as possible. Only put something you REALLY use.
" 
" KEYBINDING REWORK
" hjkl      - move
" wbe       - move
" fFtT;,    - move
" m         - mark
" '`        - mark move
" vV        - visual
" /?nN      - search
" qQ        - macro
" yp        - yank/paste
" .         - repeat
" r         - replace
" c         - change
" d         - delete
" <>        - indentation
"
" not used
" s         - same as c
" x         - same as d?
" []()
" U
