local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- vim.g.mapleader = " "
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

require("lazy").setup({
	spec = {
        -- INTERFACE
		{
			"viyic/naysayer88.vim",
			lazy = false,
			priority = 1000,
			config = function()
				vim.cmd.colorscheme("naysayer88")
			end,
		},
		{
			"folke/noice.nvim",
            tag = "v4.4.7", -- BUG: Flickering cursor
			event = "VeryLazy",
			opts = {
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					-- bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
				cmdline = {
					format = {
						cmdline = { icon = ":" },
						search_down = { icon = "/" },
						search_up = { icon = "?" },
						help = { icon = "?" },
						lua = { icon = "~" },
					},
				},
				views = {
					mini = {
						-- border = {
						-- -- 	style = "none",
						-- 	padding = { 1, 2 },
						-- },
						position = {
						 	row = 1,
						 	col = -2,
						},
						-- win_options = {
						-- 	winhighlight = {
						-- 		Normal = "NoicePopupmenu",
						-- 		--FloatBorder = "NoiceCmdlinePopupBorder",
						-- 	},
						-- },
					},
				},
			},
			dependencies = {
				"MunifTanjim/nui.nvim",
				-- "rcarriga/nvim-notify",
			}
		},

        -- UTILITY
		'tpope/vim-surround',
		"mg979/vim-visual-multi",

		-- LANGUAGES
		-- "Tetralux/odin.vim",
		{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
		{'williamboman/mason.nvim'},
		{'williamboman/mason-lspconfig.nvim'},
		{'neovim/nvim-lspconfig'},
		{'hrsh7th/cmp-nvim-lsp'},
		{'hrsh7th/nvim-cmp'},
		{'L3MON4D3/LuaSnip'},
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function () 
                local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
                parser_config.blade = {
                    install_info = {
                            url = "https://github.com/EmranMR/tree-sitter-blade",
                            files = { "src/parser.c" },
                            branch = "main",
                    },
                    filetype = "blade",
                }

				local configs = require("nvim-treesitter.configs")

				configs.setup({
                    ignore_install = { "vimdoc" },
					ensure_installed = { "javascript", "typescript", "c", "lua", "php", "php_only", "html", "blade" }, --  "vimdoc",
					sync_install = false,
					auto_install = true,
					highlight = {
						enable = true,
						additional_vim_regex_highlighting = false,
                        disable = { "vimdoc" },
					},
					indent = { enable = true },  
				})
			end
		},

        -- NAVIGATION
        'tpope/vim-vinegar',
		-- 'nvim-tree/nvim-tree.lua',
        -- {
        --     'tamago324/lir.nvim',
		-- 	dependencies = { 'nvim-lua/plenary.nvim' },
        -- },
		-- {
		-- 	'stevearc/oil.nvim',
		-- 	opts = {
		-- 		default_file_explorer = true,
		-- 	},
		-- 	-- dependencies = { "nvim-tree/nvim-web-devicons" },
		-- },
		{
			'nvim-telescope/telescope.nvim', tag = '0.1.8',
			dependencies = { 'nvim-lua/plenary.nvim' }
		},

	},
	install = { colorscheme = { "naysayer88" } },
})

local lsp_zero = require('lsp-zero')

local lsp_attach = function(client, bufnr)
	lsp_zero.default_keymaps({ buffer = bufnr })

    vim.keymap.set('n', '<C-Space>', '<cmd>lua vim.lsp.buf.hover()<cr>')
	-- local opts = {buffer = bufnr}
	-- vim.keymap.set('n', '<C-Space>', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
	-- vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
	-- vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
	-- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
	-- vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
	-- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
	-- vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
	-- vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
	-- vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
	-- vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end

lsp_zero.extend_lspconfig({
	sign_text = true,
	lsp_attach = lsp_attach,
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {},
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	},
})

---
-- Autocompletion config
---
local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
	sources = {
		{name = 'nvim_lsp'},
	},
	mapping = cmp.mapping.preset.insert({
		-- `Enter` key to confirm completion
		['<CR>'] = cmp.mapping.confirm({select = true}),

		-- Ctrl+Space to trigger completion menu
		['<C-Space>'] = cmp.mapping.complete(),

		-- Navigate between snippet placeholder
		['<C-f>'] = cmp_action.vim_snippet_jump_forward(),
		['<C-b>'] = cmp_action.vim_snippet_jump_backward(),

		-- Scroll up and down in the completion documentation
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),

		['<Tab>'] = cmp.mapping.select_next_item({ behaviour = cmp.SelectBehavior.Insert }),
		['<S-Tab>'] = cmp.mapping.select_prev_item({ behaviour = cmp.SelectBehavior.Insert })
	}),
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
})

local actions = require("telescope.actions")

require('telescope').setup({
	defaults = {
        sorting_strategy = "ascending",
        layout_strategy = "center",
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<tab>"] = actions.move_selection_next,
				["<s-tab>"] = actions.move_selection_previous,
			},
		},
	},
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-b>', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', 'B', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
vim.g.netrw_banner = 0
vim.opt.termguicolors = true
-- require("nvim-tree").setup({
--     view = {
--         signcolumn = "no",
--         float = {
--             enable = true,
--             open_win_config = {
--                 border = "none",
--             },
--         },
--     },
--     renderer = {
--         add_trailing = true,
--         root_folder_label = ":~:s?$?",
--         indent_markers = {
--             enable = true,
--         },
--         icons = {
--             show = {
--                 file = false,
--                 -- folder = false,
--                 -- git = false,
--                 folder_arrow = false,
--             },
-- 
--             glyphs = {
--                 -- default = 
-- 
--                 symlink = ">",
--                 -- modified = 
-- 
--                 hidden = ".",
-- 
--                 folder = {
--                   arrow_closed = "+",
--                   arrow_open = "-",
--                   default = "+",
--                   open = "-",
--                   --empty = "",
--                   --empty_open = "",
--                   --symlink = "",
--                   --symlink_open = "",
--                 },
-- 
--                 git = {
--                   unstaged = "✗",
--                   staged = "✓",
--                   unmerged = "",
--                   renamed = "➜",
--                   untracked = "★",
--                   deleted = "",
--                   ignored = "◌",
--                 },
--             },
--         },
--     },
-- })

-- local actions = require'lir.actions'
-- local mark_actions = require 'lir.mark.actions'
-- local clipboard_actions = require'lir.clipboard.actions'

-- require('lir').setup({
--     show_hidden_files = false,
--     ignore = {}, -- { ".DS_Store", "node_modules" } etc.
--     devicons = {
--         enable = false,
--         highlight_dirname = false
--     },
--     mappings = {
--         ['l']     = actions.edit,
--         ['<C-s>'] = actions.split,
--         ['<C-v>'] = actions.vsplit,
--         ['<C-t>'] = actions.tabedit,
-- 
--         ['h']     = actions.up,
--         ['q']     = actions.quit,
-- 
--         ['K']     = actions.mkdir,
--         ['N']     = actions.newfile,
--         ['R']     = actions.rename,
--         ['@']     = actions.cd,
--         ['Y']     = actions.yank_path,
--         ['.']     = actions.toggle_show_hidden,
--         ['D']     = actions.delete,
-- 
--         ['J'] = function()
--         mark_actions.toggle_mark()
--         vim.cmd('normal! j')
--         end,
--         ['C'] = clipboard_actions.copy,
--         ['X'] = clipboard_actions.cut,
--         ['P'] = clipboard_actions.paste,
--     },
--     float = {
--         winblend = 0,
--         curdir_window = {
--             enable = true,
--             highlight_dirname = false
--         },
--         win_opts = function()
--           local result = {
--             style = "minimal",
--             border = "none",
--           }
-- 
--           return result
--         end,
--     },
--     -- hide_cursor = true,
-- })

vim.opt.clipboard = "unnamedplus" -- BUG: Faster in WSL

vim.api.nvim_create_user_command("Cd", "cd %:p:h | pwd", {})
vim.keymap.set("n", "`", ":Cd<CR>", { silent = true })

vim.api.nvim_create_user_command("Init", "e ~/AppData/Local/nvim/init.lua", {})

vim.keymap.set("n", "<C-s>", ":update<CR>", { silent = true })
vim.keymap.set("n", "S", ":update<CR>", { silent = true })

vim.keymap.set({"n", "v"}, "H", "b")
vim.keymap.set({"n", "v"}, "L", "w")
vim.keymap.set({"n", "v"}, "j", "gj")
vim.keymap.set({"n", "v"}, "k", "gk")
vim.keymap.set({"n", "v"}, "J", "10gj")
vim.keymap.set({"n", "v"}, "K", "10gk")

vim.keymap.set({"n", "v"}, "<M-h>", "B")
vim.keymap.set({"n", "v"}, "<M-l>", "W")

vim.keymap.set("n", "Y", "y$")

vim.keymap.set("n", "<C-/>", "gcc")
vim.keymap.set("v", "<C-/>", "gc")

vim.keymap.set("n", "<C-j>", "J")
vim.keymap.set("n", "<C-k>", "Jx")

vim.keymap.set("n", "<Space>", "m0")
vim.keymap.set("n", "<S-Space>", "'0")

vim.keymap.set("n", "w", "<C-w>w")
vim.keymap.set("n", "R", "<C-r>")
vim.keymap.set("n", "<C-r>", ":%s/")
vim.keymap.set("v", "<C-r>", ":s/")

vim.keymap.set("n", "<Tab>", ">>")
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("n", "<S-Tab>", "<<")
vim.keymap.set("v", "<S-Tab>", "<gv")

vim.keymap.set("n", "dD", "\"_dd")
vim.keymap.set("v", "D", "\"_d")

vim.keymap.set("n", "0", "^")
vim.keymap.set("n", ")", "0")

vim.keymap.set("i", "<C-BS>", "<C-w>")
vim.keymap.set("c", "<C-BS>", "<C-w>")
vim.keymap.set("i", "<C-Del>", "<C-o>dw")

vim.keymap.set("n", "b", "<C-^>")
-- vim.keymap.set("n", "B", ":b ")

vim.keymap.set("i", "<M-a>", "->")
vim.keymap.set("i", "<S-Space>", "_")

vim.cmd("cd E:/lambda")
-- set backupdir=~\AppData\Local\nvim-data\backup\\
vim.opt.title = true
vim.opt.scrolloff = 3

-- set completeopt-=preview

vim.opt.showbreak = '↪ '
vim.opt.breakindent = true
vim.opt.linebreak = true

-- vim.opt.autochdir = true

-- set number
-- set relativenumber

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.splitbelow = true
vim.opt.splitright = true

-- set autoindent
-- set smartindent

-- vim.opt.mouse = nv

vim.opt.signcolumn = 'no'

-- colorscheme naysayer88
-- vim.opt.guifont = 'Consolas:h12'
vim.opt.guifont = 'Cascadia Mono:h12'
vim.api.nvim_create_autocmd({'VimEnter', 'Colorscheme'}, { pattern = '*', command = 'hi LineNrAbove guifg=#042327' })
vim.api.nvim_create_autocmd({'VimEnter', 'Colorscheme'}, { pattern = '*', command = 'hi LineNrBelow guifg=#042327' })
vim.api.nvim_create_autocmd({'VimEnter', 'Colorscheme'}, { pattern = '*', command = 'hi SignColumn guibg=none' })
-- lua << EOF
local signs = { Error = "!", Warn = "!", Hint = "?", Info = "?" } 
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- EOF

-- au FileType odin :syn match vycTodo '@\w\+'
-- au FileType odin :syn match  vycComment  '//.*'                  contains=cTodo
-- au FileType odin :syn region vycComment  start='/\*' end='\*/'   contains=cTodo
-- au FileType odin :syn match vycType      '\v<\$*\u%(\w|\$)*>'
-- au FileType odin :syn match vycConstant  '\v<%(\u|[_\$])%(\u|\d|[_\$])*>'
-- au FileType odin :hi def link vycType      Type
-- au FileType odin :hi def link vycConstant  Constant

-- vim.opt.whichwrap:append({'h', 'l'})
-- vim.opt.whichwrap = {'h', 'l', 's', 'b'}

--set wildcharm=<C-Z>
--cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>"
--cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>"
--cnoremap <expr> <left> wildmenumode() ? "\<up>" : "\<left>"
--cnoremap <expr> <right> wildmenumode() ? " \<bs>\<C-Z>" : "\<right>"
--
--set switchbuf=usetab,uselast
--set hidden

vim.api.nvim_set_keymap('c', '<up>', 'wildmenumode() ? "<left>" : "<right>"', { noremap = true, expr = true })
vim.api.nvim_set_keymap('c', '<down>', 'wildmenumode() ? "<right>" : "<down>"', { noremap = true, expr = true })
vim.api.nvim_set_keymap('c', '<left>', 'wildmenumode() ? "<up>" : "<left>"', { noremap = true, expr = true })
vim.api.nvim_set_keymap('c', '<right>', 'wildmenumode() ? "<bs><C-Z>" : "<right>"', { noremap = true, expr = true })

-- filetype plugin indent on

-- let g:html_indent_script1 = "zero"

-- (0 indent to unclosed paren
-- l1 indent to case label
-- c0 multi-line comments don't indent
-- =0 case labels don't indent
-- +0 no semicolon for odin
vim.opt.cino = {'(0', 'l1', 'c0', '=0'}

-- au FileType c,cpp setlocal comments=://
-- au FileType c,cpp setlocal commentstring=//%s
-- 
-- au BufEnter,BufNew *.php setlocal filetype=phtml
-- au BufEnter,BufNew *.f7 setlocal filetype=html
-- au Filetype phtml setlocal autoindent
-- 
-- " ---- STATUSLINE
-- function! StatuslineFilename()
--   let fname = expand('%:f')
--   return fname ==# 'undotree_2' ? 'undotree' :
--        \ fname ==# 'diffpanel_3' ? 'diffpanel' :
--        \ fname !=# '' ? fname : '[no name]'
-- endfunction
-- 
-- function! StatuslineModified()
--   return &ft =~# 'help' ? '' : &modified ? '[+] ' : &modifiable ? '' : '[-] '
-- endfunction
-- 
-- function! StatuslineReadonly()
--   return &ft !~? 'help' && &readonly ? 'readonly' : ''
-- endfunction
-- 
-- function! StatuslineLine()
--   return 'ln ' . line('.') . '.' . line('$')
-- endfunction
-- 
-- function! StatuslineFiletype()
--   return &ft !=# '' ? &ft : 'no ft'
-- endfunction
-- 
-- function! StatuslineQuickfixTitle()
--   return exists('w:quickfix_title') ? w:quickfix_title : '[no name] '
-- endfunction
-- 
-- function! StatuslineCompiling()
--   return ''
--   "neomake#statusline#get(bufnr())
-- endfunction
-- 
-- set statusline=\ %-{StatuslineFilename()}\ %-{StatuslineModified()}\|\ %-{StatuslineLine()}\ \|\ %-{StatuslineFiletype()}\ %-{StatuslineReadonly()}
-- "\ %{StatuslineCompiling()}
-- autocmd FileType qf setlocal statusline=\ %-{StatuslineQuickfixTitle()}\|\ %-{StatuslineLine()}\ \|\ qf
-- vim.opt.statusline = ' ' .. vim.fn.expand('%:f') .. ' | ln ' .. vim.fn.line('.') .. '.' .. vim.fn.line('$')
vim.opt.statusline = " %{%&bt == '' ? &ft == '' ? '%f' : '%f%m | ln %l.%c | %{&ft} %r' : '' %}"

-- make build.bat the default?
vim.opt.makeprg = 'build'
-- " nnoremap <M-m> :silent make<CR>
-- nnoremap <M-m> :Neomake!<CR>
-- autocmd FileType vim nnoremap <buffer> <M-m> :Source<CR>
-- autocmd FileType lua setlocal makeprg=run
-- autocmd FileType lua nnoremap <buffer> <M-m> :silent make!<CR>
-- autocmd FileType rust setlocal makeprg=cargo\ b\ --message-format\ short
-- 
-- set errorformat+=%f(%l:%c)\ %m " odin
-- 
-- func! ToggleQuickFix()
--     if empty(filter(getwininfo(), 'v:val.quickfix'))
--         copen
--     else
--         cclose
--     endif
-- endfunc
-- 
-- " errors
local function ToggleQuickFix()
	if vim.fn.empty(vim.fn.filter(vim.fn.getwininfo(), 'v:val.quickfix')) == 1 then
		vim.cmd('copen')
	else
		vim.cmd('cclose')
	end
end
vim.keymap.set("n", "<M-n>", ToggleQuickFix, { silent = true })
-- nnoremap <silent> <M-,> :cbefore<CR>
-- nnoremap <silent> <M-.> :cafter<CR>
-- nnoremap <silent> <M-;> :cprevious<CR>
-- nnoremap <silent> <M-'> :cnext<CR>
-- 
-- let g:user_emmet_install_global = 0
-- autocmd FileType html,css,php,htmldjango,svelte EmmetInstall
-- let g:user_emmet_leader_key='\'
-- let g:user_emmet_settings = {
--     \ 'html' : {
--         \ 'quote_char' : "'",
--     \ },
-- \}
