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
  autocmd VimEnter * PlugInstall
endif

call plug#begin($XDG_DATA_HOME . '/nvim/plugged')
" }}}
Plug 'Konfekt/FastFold'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'ap/vim-buftabline'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'itchyny/lightline.vim'
Plug 'janko-m/vim-test'
Plug 'jreybert/vimagit'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vader.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-oblique'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-pseudocl'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'kopischke/vim-stay'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
" File type specific plugins {{{
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'chrisbra/Colorizer', { 'for': ['css', 'scss'] }
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
Plug 'ledger/vim-ledger', { 'for': 'beancount' }
Plug 'lervag/vimtex', { 'for': ['tex', 'latex'] }
Plug 'nathangrigg/vim-beancount'
Plug 'othree/yajs.vim', { 'for': ['javascript', 'vue'] }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'posva/vim-vue'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
"}}}
" Color schemes {{{
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'
"}}}
call plug#end()
" }}}
" Basic settings {{{
set hidden
set termguicolors
colorscheme gruvbox
set background=dark

set guicursor=
if has('mac')
    let g:python_host_prog = '/usr/local/bin/python2'
    let g:python3_host_prog = '/usr/local/bin/python3'
else
    let g:python_host_prog = '/usr/bin/python2'
    let g:python3_host_prog = '/usr/bin/python3'
endif
set shortmess+=F

" Do not use tabs and use 4 spaces for indentation
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

"set relativenumber
set number
set undofile

set scrolloff=4

set hidden         " So not abandon hidden buffers
set hlsearch       " highlight all search results
set incsearch      " increment search
set ignorecase     " case-insensitive search
set smartcase      " uppercase causes case-sensitive search
set gdefault       " apply substitutions globally by default
set inccommand=nosplit

set clipboard=unnamed

"au TermOpen * setlocal scrollback=100000
" }}}
" Key bindings {{{
nnoremap <Space> za       " Space toggles folds
vnoremap <Space> za
noremap <tab> %

" Save and quit
inoremap <C-s> <C-O>:update<cr>
nnoremap <C-s> :update<cr>
inoremap <C-Q> <esc>:q<cr>
nnoremap <C-Q> :q<cr>

" Move up/down by on-screen lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k

" Tab to switch to next buffer, Shift-Tab to the previous one.
nnoremap <Tab> :bn<CR>|
nnoremap <S-Tab> :bp<CR>|

" Quickfix
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz
" Buffers
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>
" Tabs
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" Save one keystroke for commmands
inoremap jk <ESC>

" Quicker window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nmap <BS> <C-W>h
" Terminal mappings
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <Esc> <C-\><C-n>

nnoremap <silent> <leader><space> :nohlsearch<cr>
nnoremap <silent> U :UndotreeToggle<cr>
nnoremap <silent> <leader><leader> :Files<cr>
nnoremap <silent> <leader>b  :Buffers<cr>
nnoremap <silent> <leader>r  :Rg<cr>
nnoremap <silent> <leader>g  :Goyo<cr>
nnoremap <silent> <F8> :TagbarToggle<cr>

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

nnoremap <silent> coc
      \ :set conceallevel=<C-r>=&conceallevel == 2 ? 0 : 2<CR><CR>
      \ :set conceallevel?<CR>

" Run tests
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
" }}}
" Completion {{{
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'python': ['pyls'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

let g:deoplete#enable_at_startup = 1
"autocmd InsertEnter * call deoplete#enable()
"inoremap <silent><expr><C-Space> deoplete#mappings#manual_complete()
"autocmd CompleteDone * pclose!
"let g:UltiSnipsExpandTrigger="<c-j>"
"let g:UltiSnipsJumpForwardTrigger="<c-j>"
"let g:UltiSnipsJumpBackwardTrigger="<c-k>"

inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"
" }}}
" Misc {{{
let g:gutentags_cache_dir = $XDG_CACHE_HOME . '/nvim/tags'
let g:gutentags_ctags_exclude = ['/usr/local']
"let g:gutentags_ctags_executable = 'ctags --python-kinds=-i'

set viewoptions=cursor,folds,slash,unix

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠'
let g:ale_sign_column_always = 1

let g:colorizer_auto_filetype='css,scss'

augroup dotfiles
    autocmd!
    autocmd BufWritePost */dev/dotfiles/* silent !~/dev/dotfiles/install > /dev/null
augroup END

function! SortParagraphs() range
    execute a:firstline . ',' . a:lastline . 'd'
    let @@=join(sort(split(substitute(@@, '\n*$', '', ''), '\n\n')), '\n\n')
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
" Javascript, CSS, SCSS {{{
augroup filetypes
    autocmd!
    autocmd FileType javascript setlocal sw=2 sts=2 fdm=syntax
    autocmd FileType vue setlocal sw=2 sts=2
    autocmd FileType css setlocal sw=2 sts=2
    autocmd FileType scss setlocal sw=2 sts=2
    autocmd FileType html setlocal sw=2 sts=2
    autocmd FileType jinja setlocal sw=2 sts=2
    autocmd FileType htmljinja setlocal sw=2 sts=2
augroup END
" }}}
" C, Lua {{{
autocmd filetypes FileType c setlocal sw=2 sts=2
autocmd filetypes FileType lua setlocal sw=2 sts=2
" }}}
" Markdown {{{
autocmd filetypes FileType markdown nmap gm :LivedownToggle<CR>
let g:vim_markdown_folding_style_pythonic = 1
" }}}
" Mail {{{
autocmd filetypes FileType mail setlocal fo+=aw
"autocmd FileType mail Goyo
" }}}
" Latex {{{
autocmd filetypes FileType tex setlocal norelativenumber
let g:vimtex_compiler_latexmk = {
      \ 'build_dir': expand($HOME . '/.cache/latex-build'),
      \ }
" Better syntax hightlighting
let g:tex_flavor='latex'

call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})

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
" Beancount (with custom org-mode folding) {{{
augroup beancount
    autocmd!
    autocmd FileType beancount setlocal foldmethod=expr
    autocmd FileType beancount setlocal foldexpr=BeancountFold(v:lnum)
    autocmd FileType beancount SpeedDatingFormat %Y-%m-%d
    autocmd FileType beancount inoremap . .<C-\><C-O>:AlignCommodity<CR>
augroup END
nnoremap <leader>t :call ledger#transaction_state_toggle(line('.'), '*!')<CR>

"call deoplete#enable_logging('INFO', '/Users/jakob/deoplete')
" let g:deoplete#omni#input_patterns.beancount = '^\s+.*|#\S*|"[^"]*'

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
      \   'gitbranch': 'fugitive#head'
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
