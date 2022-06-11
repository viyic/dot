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
Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'mbbill/undotree'
Plug 'lifepillar/vim-mucomplete'
Plug 'hattya/vcvars.vim'

" file nav
" Plug 'ctrlpvim/ctrlp.vim'

Plug 'unblevable/quick-scope'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

" testing
" for new plugins, to see whether i really need it or not
Plug 'lambdalisue/fern.vim'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'cohama/lexima.vim'
Plug 'godlygeek/tabular'

" Plug 'karb94/neoscroll.nvim'

" Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Plug 'kevinhwang91/nvim-bqf', { 'for': 'qf' }
Plug 'andymass/vim-matchup'
call plug#end()

" neoscroll
" only for <C-u> and <C-d>
" lua << EOF
" require('neoscroll').setup()
" local t = {}
" t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '25'}}
" t['<C-d>'] = {'scroll', {'vim.wo.scroll', 'true', '25'}}
" t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '25'}}
" t['<C-f>'] = {'scroll', {'vim.api.nvim_win_get_height(0)', 'true', '25'}}
" t['zt']    = {'zt', {'25'}}
" t['zz']    = {'zz', {'25'}}
" t['zb']    = {'zb', {'25'}}

" require('neoscroll.config').set_mappings(t)
" EOF

" matchup
" lua << EOF
" require'nvim-treesitter.configs'.setup {
"     matchup = {
"         enable = true
"     }
" }
" EOF
" let g:matchup_matchparen_offscreen = { 'method': 'popup', 'border': 1 }
let g:matchup_matchparen_offscreen = {}

" bqf
" lua << EOF
" package.path = "C:\\Users\\user\\.config\\nvim\\plugged\\nvim-bqf\\lua\\?.lua;" .. package.path
" require('bqf').setup({
"     magic_window = false
" })
" EOF

" telescope
lua << EOF
require('telescope').setup {
    defaults = {
        default_mappings = {
            i = {
                ['<Down>'] = 'move_selection_next',
                ['<Up>'] = 'move_selection_previous',
                ['<S-Tab>'] = 'move_selection_next',
                ['<Tab>'] = 'move_selection_previous',
                ['<CR>'] = 'select_default',
                ['<C-v>'] = 'select_vertical',
                ['<C-h>'] = 'which_key',
                ['jj'] = 'close',
                ['<Esc>'] = 'close',
            },
            n = {
                ['<Down>'] = 'move_selection_next',
                ['<Up>'] = 'move_selection_previous',
                ['j'] = 'move_selection_next',
                ['k'] = 'move_selection_previous',
                ['<S-Tab>'] = 'move_selection_next',
                ['<Tab>'] = 'move_selection_previous',
                ['<CR>'] = 'select_default',
                ['<Esc>'] = 'close',
                ['?'] = 'which_key',
            }
        },
        layout_strategy = 'vertical',
        layout_config = {
            width = 0.5,
        }
    },
}
EOF

" au FileType TelescopePrompt inoremap <silent> <Esc> <Esc>:quit!<CR>

" undotree
nnoremap <silent> <M-u> :UndotreeToggle<CR>
let g:undotree_SplitWidth = 33

" ctrlp
let g:ctrlp_cmd = 'CtrlPMRUFiles'
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_types = ['mru', 'buf', 'mixed']
let g:ctrlp_extensions = ['mixed']

" quick-scope
let g:qs_filetype_blacklist = ['qf', 'ctrlp', 'undotree']

" fern
let g:fern#hide_cursor = 1
let g:fern#default_hidden = 1
let g:fern#disable_default_mappings = 1
let g:fern#renderer#default#leading = '   '
let g:fern#renderer#default#leaf_symbol = '   '
let g:fern#renderer#default#collapsed_symbol = ' + '
let g:fern#renderer#default#expanded_symbol = ' - '

func! s:quit_fern()
    if len(getbufinfo({'buflisted':1})) == 0
        execute ':bd'
    else
        execute ':bp'
    endif
endfunc

func! s:init_fern() abort
    nmap <buffer> <nowait> d <Plug>(fern-action-new-dir)
    nmap <buffer> <nowait> f <Plug>(fern-action-new-file)

    nmap <buffer> <nowait> c <Plug>(fern-action-copy)

    nmap <buffer> <nowait> D <Plug>(fern-action-trash)

    nmap <buffer> <nowait> R <Plug>(fern-action-rename)

    nmap <buffer> <nowait> <F5> <Plug>(fern-action-reload)
    nmap <buffer> <nowait> l <Plug>(fern-action-open-or-expand)
    nmap <buffer> <nowait> h <Plug>(fern-action-collapse)
    nmap <buffer> <nowait> <Return> <Plug>(fern-action-open-or-enter)
    nmap <buffer> <nowait> <Backspace> <Plug>(fern-action-leave)
    nmap <buffer> <nowait> L <Plug>(fern-action-enter)
    nmap <buffer> <nowait> H <Plug>(fern-action-leave)

    nmap <buffer> <nowait> m <Plug>(fern-action-mark)
    vmap <buffer> <nowait> m <Plug>(fern-action-mark)

    nmap <buffer> <nowait> y <Plug>(fern-action-yank)

    nmap <buffer> <nowait> !  <Plug>(fern-action-hidden)

    nmap <buffer> <nowait> <C-c> <Plug>(fern-action-cancel)
    nmap <buffer> <nowait> <C-l> <Plug>(fern-action-redraw)

    nnoremap <buffer> <silent> q :call <SID>quit_fern()<CR>
endfunc
augroup my-fern
    autocmd! *
    autocmd FileType fern call s:init_fern()
augroup END

func! s:on_highlight() abort
    hi link FernMarkedLine Statement
    hi link FernMarkedText Statement
    hi SignColumn guibg=#042327
endfunc
augroup my-fern-highlight
  autocmd!
  autocmd User FernHighlight call s:on_highlight()
augroup END

nnoremap <silent> <M-e> :Fern . -reveal=%<CR>

" tabular
nnoremap <M-a> :Tabularize /=<CR>
vnoremap <M-a> :Tabularize /=<CR>

" lexima
" let g:lexima_no_default_rules=1
let g:lexima_enable_basic_rules=0
let g:lexima_enable_newline_rules=0
" call lexima#add_rule({'char': '{', 'at': '\(struct\|union\) .*\%#', 'input_after': '};'})
" call lexima#add_rule({'char': '{', 'at': '\(int\|float\|char\).*= \%#', 'input_after': '};'})
" call lexima#add_rule({'char': '{', 'at': 'case .*\%#', 'input_after': '} break;'})
"
" call lexima#add_rule({'char': '<CR>', 'at': '\(struct\|union\|enum\) .*{\%#$', 'input_after': '<CR>};'})
" call lexima#add_rule({'char': '<CR>', 'at': '\(case\|default\).*: {\%#$', 'input_after': '<CR>} break;'})
" call lexima#add_rule({'char': '<CR>', 'at': '{\%#}', 'input_after': '<CR>'})
" call lexima#add_rule({'char': '<CR>', 'at': '{\%#$', 'input_after': '<CR>}', 'except': '\C\v^(\s*)\S.*%#\n%(%(\s*|\1\s.+)\n)*\1\}'})

call lexima#add_rule({'char': '<CR>', 'at': '\(struct\|union\|enum\) .*{\%#$', 'input': '<CR><CR>};<Esc><Up>"_s'})
call lexima#add_rule({'char': '<CR>', 'at': '\(case\|default\).*: {\%#$', 'input': '<CR><CR>} break;<Esc><Up>"_s'})
call lexima#add_rule({'char': '<CR>', 'at': '{\%#}', 'input': '<CR><CR><Esc><Up>"_s'})
call lexima#add_rule({'char': '<CR>', 'at': '{\%#$', 'input': '<CR><CR>}<Esc><Up>"_s', 'except': '\C\v^(\s*)\S.*%#\n%(%(\s*|\1\s.+)\n)*\1\}'})

" indent blankline
set list
let g:indent_blankline_show_first_indent_level = v:false
let g:indent_blankline_max_indent_increase = 1
let g:indent_blankline_show_trailing_blankline_indent = v:false
autocmd VimEnter,Colorscheme * :hi IndentBlanklineChar guifg=#666666 " gui=nocombine
autocmd VimEnter,Colorscheme * :hi IndentBlanklineChar guifg=#666666 " gui=nocombine

" -------- CONFIGURATIONS
cd D:\programming
set title
set scrolloff=3

set showbreak=↪\ 
set breakindent
set linebreak

set autochdir

set number
set relativenumber

autocmd VimEnter,Colorscheme * :hi LineNr guifg=#666666
autocmd VimEnter,Colorscheme * :hi LineNrAbove guifg=#042327
autocmd VimEnter,Colorscheme * :hi LineNrBelow guifg=#042327

set tabstop=4
set shiftwidth=4
set expandtab

set splitright

set switchbuf+=uselast

set autoindent
set smartindent

set mouse=nv

set cino=(0,l1,c0

colorscheme naysayer88
set guifont=Consolas:h10
hi QuickFixLine guibg=#031216

set whichwrap+=<,>,h,l,[,]

set wildcharm=<C-Z>
cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>"
cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>"
cnoremap <expr> <left> wildmenumode() ? "\<up>" : "\<left>"
cnoremap <expr> <right> wildmenumode() ? " \<bs>\<C-Z>" : "\<right>"

set switchbuf=usetab
set hidden

filetype plugin indent on

let g:html_indent_script1 = "zero"

autocmd FileType c,cpp setlocal comments=://
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
" let g:latest_cpp = '17.0' " '2022' vcvars#list()[-1]

func! InitCPP()
    let latest_cpp = vcvars#list()[-1]
    let vars = call('vcvars#get', [latest_cpp])
    if empty(vars)
        echo 'InitCPP Error: vars is empty'
        return
    endif

    let path = $PATH
    let include = $INCLUDE
    let lib = $LIB
    let libpath = $LIBPATH
    let sep = ';'
    let $PATH    = join(vars.path + [path], sep)
    let $INCLUDE = join(vars.include + [include], sep)
    let $LIB     = join(vars.lib + [lib], sep)
    let $LIBPATH = join(vars.libpath + [libpath], sep)
endfunc
command! Vcvars execute ':call InitCPP()'
" autocmd VimEnter * call InitCPP()

nnoremap <M-m> :make<CR>
autocmd FileType c,cpp setlocal makeprg=build
" autocmd FileType c,cpp nnoremap <buffer> <silent> <M-m> :call vcvars#call('make', g:latest_cpp)<CR>
autocmd FileType vim nnoremap <buffer> <M-m> :Source<CR>


func! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunc

" errors
nnoremap <silent> <M-n> :call ToggleQuickFix()<CR>
nnoremap <silent> <M-,> :cbefore<CR>
nnoremap <silent> <M-.> :cafter<CR>
nnoremap <silent> <M-<> :cprevious<CR>
nnoremap <silent> <M->> :cnext<CR>

" -------- MAPPINGS

" disable highlighting with escape
nnoremap <silent> <Esc> <Esc>:noh<CR>

"  exit terminal
tnoremap <S-Escape> <C-\><C-N>

" ---- NAVIGATION
" start of the line
noremap 0 ^
noremap ^ 0
" WARNING: i don't use text object motions(?)
noremap ) 0

nnoremap <silent> k gk
nnoremap <silent> j gj
vnoremap <silent> k gk
vnoremap <silent> j gj

" ctrl u and d are too hard to follow because it changes your view
" { and } don't jump consistently so it might cause confusion
" 10 is just a random number
nnoremap <silent> K 10gk
nnoremap <silent> J 10gj
vnoremap <silent> K 10k
vnoremap <silent> J 10j

nnoremap <silent> <M-k> 20gk
nnoremap <silent> <M-j> 20gj
vnoremap <silent> <M-k> 20gk
vnoremap <silent> <M-j> 20gj

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

" visual search
vnoremap / y/\V<C-R>=escape(@",'/\')<CR><CR>

" quick markings
func! MarkCount(count)
    execute ":normal! m" . a:count
    echom 'mark ' . a:count . ' set on line ' . line('.')
endfunc

nnoremap <silent> <Space>   :<C-u>call MarkCount(v:count)<CR>
nnoremap <silent> <S-Space> :<C-u>execute ":normal! '" . v:count<CR>
nnoremap M '

" emacs-style go-to-line
" i can't really do 'line'G because of my broken number keys
" i think this is better 'line'G
func! GoToLine()
    call inputsave()
    let line = input('go to line: ')
    call inputrestore()
    if !empty(line)
        if line !~ '[^0-9]'
            execute ":normal! " . line . "G"
        else
            redraw
            echom "no non-digit characters!"
        endif
    endif
endfunc

nnoremap gl :call GoToLine()<CR>

" quick window switch
func! CycleWinSkipQF(backwards)
    let start_win = winnr()
    let key = 'w'
    if (a:backwards == 1)
        let key = 'W'
    endif
    execute 'wincmd ' . key
    while &buftype ==# 'quickfix' && winnr() != start_win
        execute 'wincmd ' . key
    endwhile
endfunc

let g:last_used_win = 0
func! CycleWinToQF()
    if &buftype ==# 'quickfix'
        if g:last_used_win > 0
            execute g:last_used_win . "wincmd w"
            let g:last_used_win = 0
        endif
        return
    endif

    let start_win = winnr()
    let g:last_used_win = start_win
    wincmd w
    let curr_win = winnr()
    while &buftype !=# 'quickfix' && curr_win != start_win
        wincmd w
        let curr_win = winnr()
    endwhile
    if curr_win == start_win
        let g:last_used_win = 0
    endif
endfunc

nnoremap <silent> w :call CycleWinSkipQF(0)<CR>
nnoremap <silent> W :call CycleWinSkipQF(1)<CR>
nnoremap <silent> <M-w> :call CycleWinToQF()<CR>
" nnoremap <M-w> <C-W>w
" nnoremap <M-W> <C-W>W

" buffer
" :vert/tab sb
" TODO: better buffer????
nnoremap b <C-^>
" nnoremap B :b 
" nnoremap B :CtrlPBuffer<CR>
nnoremap <silent> B :lua require('telescope.builtin').buffers({ignore_current_buffer = true, sort_mru = true})<CR>
nnoremap <silent> <C-P> :lua require('telescope.builtin').oldfiles()<CR>

" auto-complete filename
inoremap <silent> <C-F> <C-X><C-F>

nnoremap <M-f> %
vnoremap <M-f> %
" nmap <M-f> *
" nmap <M-F> #

" find cpp function WIP
" nnoremap <M-/> ^\(internal\|static\)*\s*\(\w\|\*\)\+\s\+\(\w\|\*\)\+(.*)\_s*{

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

" emacs-style replace
" edited version of https://stackoverflow.com/questions/7598133/how-to-search-and-replace-globally-starting-from-the-cursor-position-and-wrappi
func! Replace()
    call inputsave()
    let find = input('find: ')
    let replace = input('replace: ')
    call inputrestore()

    if getregtype('r') != ''
        " save previous macro register
        let l:register = getreg('r')
    endif
    normal! qr
    redir => l:replacements
    try
        execute ',$s/' . find. '/' . replace . '/gce#'
    catch /^Vim:Interrupt$/
        return
    finally
        normal! q
        let l:transcript = getreg('r')
        if exists('l:register')
            call setreg('r', l:register)
        endif
    endtry
    redir END

    if len(l:replacements) > 0
        " at least one instance of pattern was found
        let l:last = strpart(l:transcript, len(l:transcript) - 1)
        if l:last ==# 'l' || l:last ==# 'q' || l:last ==# '^['
            return
        endif
    endif

    " loop around to top of file and continue
    if line("''") > 1
        1,''-&&"
    endif
endfunc

nnoremap <Leader>r :call Replace()<CR>

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
imap <M-U> _
" ^ for convenience typing constants
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
cmap <M-U> _
cmap <M-f> 5
cmap <M-F> %
cmap <M-s> 6
cmap <M-S> ^
cmap <M-g> `
cmap <M-G> ~

inoremap <M-a> ->



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
