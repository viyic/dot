" ### #  # ### ###
"  #  ## #  #   #
"  #  # ##  #   #
" ### #  # ###  #
"
" Cheatsheet:
" <M-u> Undotree
"
" <C-P>: CtrlPMixed
" <C-F>: Change modes
"
" b/B: buffer
" <C-W><S-T>: move current buffer to new tab
"
" U: toggle comment
"
" TODO:
" . ctrlp is useless? i only need MRU?
" . subtler indent guide color
" . fix double tab autocompletion
" . fix naysayer88 tab color
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

" undotree
nnoremap <silent> <M-u> :UndotreeToggle<CR>
let g:undotree_SplitWidth = 33

" ctrlp
let g:ctrlp_cmd = 'CtrlPMRUFiles'
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_types = ['mru', 'mixed']
let g:ctrlp_extensions = ['mixed']

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size  = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#182327
"101a1a
" 
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#042327

" -------- CONFIGURATIONS
set scrolloff=3
set sidescrolloff=5

set autochdir

set tabstop=4
set shiftwidth=4
set expandtab

set splitright

set autoindent
set smartindent

set mouse=nv

colorscheme naysayer88
set guifont=Consolas:h10

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

" ---- STATUSLINE
function! StatuslineFilename()
  let fname = expand('%:f')
  return fname ==# 'undotree_2' ? 'undotree' :
       \ fname ==# 'diffpanel_3' ? 'diffpanel' :
       \ fname !=# '' ? fname : '[no name]'
endfunction

function! StatuslineModified()
  return &ft =~# 'help' ? '' : &modified ? '[+] ' : &modifiable ? '' : '[-] '
endfunction

function! StatuslineReadonly()
  return &ft !~? 'help' && &readonly ? 'readonly' : ''
endfunction

function! StatuslineLine()
  return 'ln ' . line('.') . '.' . line('$')
endfunction

function! StatuslineFiletype()
  return &ft !=# '' ? &ft : 'no ft'
endfunction

function! StatuslineQuickfixTitle()
  return exists('w:quickfix_title') ? w:quickfix_title : '[no name] '
endfunction

set statusline=\ %-{StatuslineFilename()}\ %-{StatuslineModified()}\|\ %-{StatuslineLine()}\ \|\ %-{StatuslineFiletype()}\ %-{StatuslineReadonly()}
autocmd FileType qf setlocal statusline=\ %-{StatuslineQuickfixTitle()}\|\ %-{StatuslineLine()}\ \|\ qf

" ---- COMPILING
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

" errors
nnoremap <silent> <M-n> :call ToggleQuickFix()<CR>
nnoremap <silent> <M-,> :cbefore<CR>
nnoremap <silent> <M-.> :cafter<CR>
nnoremap <silent> <M-<> :cprevious<CR>
nnoremap <silent> <M->> :cnext<CR>

" -------- MAPPINGS

" disable highlighting with escape
nnoremap <silent> <ESC> :noh<CR><ESC>

"  exit terminal
tnoremap <S-Escape> <C-\><C-N>

" ---- NAVIGATION
" start of the line
noremap 0 ^
noremap ^ 0
" WARNING: i don't use text object motions(?)
noremap ) 0

" ctrl u and d are too hard to follow because it changes your view
" { and } don't jump consistently so it might cause confusion
" 10 is just a random number
nnoremap K 10k
nnoremap J 10j
vnoremap K 10k
vnoremap J 10j

nnoremap <M-k> <C-u>
nnoremap <M-j> <C-d>
vnoremap <M-k> <C-u>
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

" quick markings
function! MarkCount(count)
    execute ":normal! m" . a:count
    echo 'mark ' . a:count . ' set on line ' . line('.')
endfunction

nnoremap <silent> <Space>   :<C-u>call MarkCount(v:count)<CR>
nnoremap <silent> <S-Space> :<C-u>execute ":normal! '" . v:count<CR>
nnoremap M '

" quick window switch
" do we need W?
nnoremap w <C-W>w
nnoremap W <C-W>W
nnoremap <M-w> <C-W>w

" buffer
" :vert/tab sb
" TODO: better buffer????
nnoremap b <C-^>
nnoremap B :b 

" file
" TODO: better file, make it like mark? E opens current dir,
" 1E opens from a list
nnoremap E1 :call feedkeys(':e %:p:h<Tab>', 't')<CR>
nmap EE E1
nnoremap E2 :e D:\programming\
nnoremap E3 :e C:\Users\user\Documents\
nnoremap E4 :e D:\sch\KULIAH\

" auto-complete filename
inoremap <silent> <C-F> <C-X><C-F>

nnoremap <M-f> %
" nmap <M-f> *
" nmap <M-F> #

" ---- EDITING
" ctrl+backspace
" TODO: cnoremap <C-Del>
inoremap <C-BS> <C-W>
cnoremap <C-BS> <C-W>
inoremap <C-Del> <C-o>dw
" inoremap <C-Del> X<Esc>lbce

" delete without cut
nnoremap dD "_dd
vnoremap D "_d

" indentation
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

vnoremap <Space> =

vnoremap > >gv
vnoremap < <gv

" commenting
nmap U gcc
vmap U gc

" replace
nnoremap <M-r> :%s/
vnoremap <M-r> :s/

" i almost never use replace mode
" so i use a more pleasant key for redo
nnoremap R <C-r>
nnoremap <C-r> R

" D deletes to the end of line, C too
" So Y should be the same imo
nnoremap Y y$

" ---- COMMANDS
command! Init execute ':e C:\Users\user\AppData\Local\nvim\init.vim'
command! Source execute ':source $MYVIMRC'
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

" Java
autocmd BufNewFile *.java
            \ exe "normal Ipublic clas \<BS>s " . expand('%:t:r') . " {\npublic static void main(String[] args) {\nW\<BS>\n}\n}\<Esc>3G$"

" C++
nnoremap <silent> <M-b> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" ---- BROKEN KEYBOARD MAPS D:
nmap <silent> <M-v> <C-V>

" we probably don't need <C-S> anymore, just use S
nmap <silent> S <C-S>

" vim completes me is kind of annoying sometimes
" (require me to tap space twice), find fix or just use this
" imap <silent> <M-n> <C-N>
" imap <silent> <M-p> <C-P>

" + is used quite a lot, so use <M-p> instead of <M-Q>, same with _
imap <M-q> =
imap <M-p> +
imap <M-m> -
imap <M-u> _
imap <M-f> 5
imap <M-F> %
imap <M-s> 6
imap <M-S> ^
imap <M-g> `
imap <M-G> ~

cmap <M-q> =
cmap <M-p> +
cmap <M-m> -
cmap <M-u> _
cmap <M-f> 5
cmap <M-F> %
cmap <M-s> 6
cmap <M-S> ^
cmap <M-g> `
cmap <M-G> ~



" SENT'S INIT.VIM MANIFESTO
" 
" 1. Screw the default vim keybindings. It's decent,
"    but if you have a better keybinding, use it.
" 2. Screw the "vim purists". You shouldn't restrict yourself with not
"    being able to move in Insert mode just because "it's not the vim way".
"    Do things that make you the most comfortable.
" 3. Utilize Alt key. I use GUI so it shouldn't be a problem.
" 4. Make it as minimal as possible. Only put something you *really* use.
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
