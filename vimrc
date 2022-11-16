" vim: set foldmethod=marker:
scriptencoding utf-8
" Directories {{{
set backupdir-=.
if !isdirectory(&backupdir)
    call mkdir(&backupdir, 'p')
endif
" }}}
" Plugins {{{
" setup {{{
if empty(glob($XDG_DATA_HOME . '/nvim/site/autoload/plug.vim'))
    silent !echo "Installing vim-plug..."
    silent !curl -fLo $XDG_DATA_HOME/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    augroup plug_install
        autocmd!
        autocmd VimEnter * PlugInstall
    augroup END
endif

call plug#begin($XDG_DATA_HOME . '/nvim/plugged')
" }}}
Plug 'Konfekt/FastFold'
Plug 'ap/vim-buftabline'
Plug 'itchyny/lightline.vim'
Plug 'vim-test/vim-test'
Plug 'jreybert/vimagit'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vader.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-oblique'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-pseudocl'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'kopischke/vim-stay'
Plug 'mbbill/undotree'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdateSync'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'nvim-tree/nvim-tree.lua'
" Language server {{{
Plug 'neovim/nvim-lspconfig'
" }}}
" Autocompletion {{{
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
" }}}
" File type specific plugins {{{
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'ledger/vim-ledger', { 'for': 'beancount' }
Plug 'lervag/vimtex'
Plug 'nathangrigg/vim-beancount', { 'for': 'beancount' }
Plug 'simrat39/rust-tools.nvim'
" }}}
" Color schemes {{{
Plug 'morhetz/gruvbox'
" }}}
call plug#end()
" }}}
" nvim-treesitter {{{
lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "bash",
        "css",
        "html",
        "javascript",
        "json",
        "lua",
        "rust",
        "svelte",
        "typescript",
        "vim",
    },
    highlight = {
        enable = true
    },
}
EOF
" }}}
" Basic settings {{{
set termguicolors
colorscheme gruvbox
set mouse=a

let g:python3_host_prog = '/usr/bin/python3'
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0

" Do not use tabs and use 4 spaces for indentation
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

set number
set undofile

set scrolloff=4

set ignorecase " case-insensitive search
set smartcase  " uppercase causes case-sensitive search
set gdefault   " apply substitutions globally by default
set inccommand=split

" }}}
" nvim-tree {{{
lua <<EOF
-- TODO: move this to the start of the file.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
    diagnostics = {
        enable = true,
    },
    update_focused_file = {
        enable = true,
    },
    renderer = {
        icons = {
            show = {
                file = false,
                folder = false,
                folder_arrow = false,
            },
            git_placement = 'after',
        },
    },
})
EOF
" }}}
" Key bindings {{{
nnoremap <Space> za
nnoremap <Space><Space> za
vnoremap <Space> za
vnoremap <Space><Space> za
noremap <tab> %
" Save one keystroke for commmands
inoremap jk <ESC>

" Save and quit {{{
inoremap <C-s> <C-O>:update<cr>
nnoremap <C-s> :update<cr>
inoremap <C-Q> <esc>:q<cr>
nnoremap <C-Q> :q<cr>
" }}}
" Move up/down by on-screen lines {{{
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k
" }}}
" Move between quickfix, buffers, tabs with [ {{{
" Quickfix
nnoremap <silent> ]q :cnext<cr>zz
nnoremap <silent> [q :cprev<cr>zz
nnoremap <silent> ]l :lnext<cr>zz
nnoremap <silent> [l :lprev<cr>zz
" Buffers
nnoremap <silent> ]b :bnext<cr>
nnoremap <silent> [b :bprev<cr>
" Tabs
nnoremap <silent> ]t :tabn<cr>
nnoremap <silent> [t :tabp<cr>
" }}}
" Quicker window navigation {{{
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nmap <BS> <C-W>h
" }}}
" Terminal mappings {{{
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <Esc> <C-\><C-n>
" }}}
" Commands {{{
nmap <silent> <leader>f <Plug>(ale_fix)
nnoremap <silent> <leader><space> :nohlsearch<cr>
nnoremap <silent> T :NvimTreeToggle<cr>
nnoremap <silent> U :UndotreeToggle<cr>
nnoremap <silent> <leader><leader> :Files<cr>
nnoremap <silent> <leader>b  :Buffers<cr>
nnoremap <silent> <leader>r  :Rg<cr>

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

nnoremap <silent> coc
            \ :set conceallevel=<C-r>=&conceallevel == 2 ? 0 : 2<CR><CR>
            \ :set conceallevel?<CR>
" }}}
" Run tests {{{
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
" }}}
" }}}
" nvim-lspconfig {{{
lua <<EOF
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')

-- Keymappings mostly as recommended in https://github.com/neovim/nvim-lspconfig#Suggested-configuration
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local servers = { 'pyright', 'tsserver', 'svelte' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

-- rust-tools calls lspconfig.setup, so do not do that twice.
local rust_tools = require("rust-tools")
rust_tools.setup({
	server = {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
        end,
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					command = "clippy"
				}
			}
		}
	},
})
rust_tools.inlay_hints.enable()
EOF
" }}}
" Completion {{{
" let g:UltiSnipsSnippetDirectories = [$HOME.'/dev/dotfiles/snippets']
" let g:UltiSnipsExpandTrigger       = '<C-j>'
" let g:UltiSnipsJumpForwardTrigger  = '<C-j>'
" let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

set completeopt=menu,menuone,noselect

lua <<EOF
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end,
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
EOF
" }}}
" Misc {{{
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠'
" let g:ale_sign_column_always = 1

lua <<EOF
require'colorizer'.setup()
EOF

augroup dotfiles
    autocmd!
    autocmd BufWritePost */dev/dotfiles/* silent !make -C ~/dev/dotfiles > /dev/null
augroup END

function! SortParagraphs() range
    execute a:firstline . ',' . a:lastline . 'd'
    let @@=join(sort(split(substitute(@@, '\n*$', '', ''), "\n\n")), "\n\n")
    put!
endfunction
" }}}
" Ripgrep {{{
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)
" }}}
" File types {{{
let g:ale_linter_aliases = {
\   'svelte': ['javascript'],
\}
let g:ale_linters = {
\   'svelte': ['eslint'],
\   'typescript': ['eslint', 'tsserver'],
\   'sh': ['shellcheck', 'shell'],
\   'zsh': ['shellcheck', 'shell'],
\   'rust': [],
\}
let g:ale_fixers = {
\   '*': ['prettier', 'eslint'],
\   'javascript': ['prettier', 'eslint'],
\   'javascriptreact': ['prettier', 'eslint'],
\   'python': ['black'],
\   'rust': ['rustfmt'],
\   'sh': ['shfmt'],
\   'svelte': ['prettier', 'eslint'],
\   'typescript': ['prettier'],
\   'zsh': ['shfmt'],
\}
" Rust {{{
" let g:ale_rust_cargo_use_clippy = 1
augroup shell
    autocmd!
    autocmd FileType rust setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()
augroup END
" }}}
" Shell {{{
let g:ale_sh_shfmt_options = '-i 4'
augroup shell
    autocmd!
    autocmd FileType sh,zsh setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()
augroup END
" }}}
" Javascript, CSS, SCSS {{{
augroup filetypes
    autocmd!
    autocmd FileType vim setlocal shiftwidth=4 softtabstop=4
    autocmd FileType javascript,javascriptreact,typescript,typescriptreact setlocal shiftwidth=2 softtabstop=2 foldmethod=expr foldexpr=nvim_treesitter#foldexpr()
    autocmd FileType svelte setlocal shiftwidth=2 softtabstop=2 foldmethod=expr foldexpr=nvim_treesitter#foldexpr()
    autocmd FileType css,scss setlocal shiftwidth=2 softtabstop=2
    autocmd FileType html,jinja,jinja.html setlocal shiftwidth=2 softtabstop=2
augroup END
" }}}
" C, Lua {{{
autocmd filetypes FileType c setlocal shiftwidth=2 softtabstop=2
autocmd filetypes FileType lua setlocal shiftwidth=2 softtabstop=2
" }}}
" Mail {{{
autocmd filetypes FileType mail setlocal formatoptions+=aw
" }}}
" Latex {{{
" Better syntax hightlighting
let g:tex_flavor='latex'

let g:vimtex_compiler_method = 'tectonic'
let g:vimtex_compiler_tectonic = {
            \ 'build_dir': expand($HOME . '/.cache/latex-build'),
            \ }
let g:vimtex_fold_enabled = 1
let g:vimtex_motion_enabled = 1
let g:vimtex_matchparen_enabled = 0

let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_imaps_list = []

augroup vimtex_config
    autocmd!
    autocmd User VimtexEventInitPost VimtexCompile
augroup END
" }}}
" Python {{{
augroup python
    autocmd!
    autocmd FileType python nnoremap <leader>i :ImportName<CR>
    autocmd FileType python setlocal foldmethod=expr
    autocmd FileType python setlocal foldexpr=nvim_treesitter#foldexpr()
augroup END
" Beancount (with custom org-mode folding) {{{
augroup beancount
    autocmd!
    autocmd FileType beancount setlocal foldmethod=expr
    autocmd FileType beancount setlocal foldexpr=BeancountFold(v:lnum)
    autocmd FileType beancount SpeedDatingFormat %Y-%m
    autocmd FileType beancount SpeedDatingFormat %Y-%m-%d
    autocmd FileType beancount inoremap . .<C-\><C-O>:AlignCommodity<CR>
    autocmd FileType beancount nnoremap <leader>t :call ledger#transaction_state_toggle(line('.'), '*!')<CR>
augroup END

function! BeancountFold(lnum)
    let l1 = getline(a:lnum)
    if l1 =~# '^*'
        return '>'.match(l1, '[^*]')
    endif
    return '='
endfunction
" }}}
" }}}
" Lightline {{{
set laststatus=2
let g:lightline = {
            \ 'colorscheme': 'seoul256',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'readonly', 'filename', 'modified', 'gitbranch' ] ],
            \ },
            \ 'component_function': {
            \   'gitbranch': 'FugitiveHead'
            \ },
            \ }
" }}}
" Terminal colors {{{
" dark0 + gray
let g:terminal_color_0 = '#282828'
let g:terminal_color_8 = '#928374'

" neurtral_red + bright_red
let g:terminal_color_1 = '#cc241d'
let g:terminal_color_9 = '#fb4934'

" neutral_green + bright_green
let g:terminal_color_2 = '#98971a'
let g:terminal_color_10 = '#b8bb26'

" neutral_yellow + bright_yellow
let g:terminal_color_3 = '#d79921'
let g:terminal_color_11 = '#fabd2f'

" neutral_blue + bright_blue
let g:terminal_color_4 = '#458588'
let g:terminal_color_12 = '#83a598'

" neutral_purple + bright_purple
let g:terminal_color_5 = '#b16286'
let g:terminal_color_13 = '#d3869b'

" neutral_aqua + faded_aqua
let g:terminal_color_6 = '#689d6a'
let g:terminal_color_14 = '#8ec07c'

" light4 + light1
let g:terminal_color_7 = '#a89984'
let g:terminal_color_15 = '#ebdbb2'
" }}}
