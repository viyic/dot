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
" gb: switch buffer
" 
" [Visual] + <Right Mouse>: Find
" [Visual] + <Middle Mouse>: Copy

" -------- PLUGINS
call plug#begin('~/.config/nvim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'tomasr/molokai'
Plug 'ap/vim-css-color'
Plug 'mbbill/undotree'
Plug 'weakish/rcshell.vim'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'
Plug 'valloric/matchtagalways'
Plug 'tpope/vim-commentary'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'DavidEGx/ctrlp-smarttabs'
call plug#end()

" color scheme
colorscheme molokai
set guifont=Tamzen:h12

" lightline
set noshowmode
let g:lightline = {
	\ 'colorscheme': 'wombat',
	\ 'separator': { 'left': '▓▒░', 'right': '░▒▓' },
	\ 'subseparator': { 'left': '', 'right': '' },
	\ 'active': {
	\	'left': [ [ 'filename', 'modified' ],
	\		  [ ],
	\		  [ 'readonly' ] ],
	\	'right': [ [ 'lineinfo' ],
	\		   [ 'percent' ],
	\		   [ 'filetype' ] ]
	\ },
	\ 'component_function': {
	\ 	'filename': 'LightlineFilename',
	\ 	'modified': 'LightlineModified',
	\ 	'readonly': 'LightlineReadonly',
	\ }
	\ }

function! LightlineFilename()
  let fname = expand('%:t')
  return fname ==# 'undotree_2' ? 'Undotree' :
       \ fname ==# 'diffpanel_3' ? 'Diffpanel' :
       \ fname !=# '' ? fname : '[No Name]'
endfunction
function! LightlineModified()
  return &ft =~# 'help' ? '' : &modified ? '[+]' : &modifiable ? '' : '[-]'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? 'readonly' : ''
endfunction

" undotree
nnoremap <silent> <F5> :UndotreeToggle<CR>
let g:undotree_SplitWidth = 33

" ctrlp
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_switch_buffer = 'et'
"let g:ctrlp_extensions = ['smarttabs']
"let g:ctrlp_smarttabs_modify_tabline = 0

" -------- CONFIGURATIONS
set number
set relativenumber

set autochdir

set tabstop=4
set shiftwidth=4

set splitright

set autoindent
set smartindent

set listchars=tab:\:\ 
set list

set switchbuf=usetab

filetype plugin indent on

" start of the line
noremap 0 ^
noremap ^ 0

" ctrl+s saving
noremap  <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <Esc>:update<CR>gi

" visual indentation
vnoremap > >gv
vnoremap < <gv

" switching buffer
nnoremap gb :call feedkeys(':vertical sb <Tab>', 't')<CR>

" wrap
set whichwrap+=<,>,h,l,[,]

" commands
command Init :vs C:\Users\user\AppData\Local\nvim\init.vim
command Source :source $MYVIMRC

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
