" vim: set foldmethod=marker:
scriptencoding utf-8
" Directories {{{
set backupdir-=.
if !isdirectory(&backupdir)
    call mkdir(&backupdir, 'p')
endif
" }}}
" Plugins {{{
let g:polyglot_disabled = ['latex']
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
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips'
Plug 'ap/vim-buftabline'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'janko-m/vim-test'
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
Plug 'ledger/vim-ledger', { 'for': 'beancount' }
Plug 'lervag/vimtex', { 'for': ['tex', 'latex'] }
Plug 'nathangrigg/vim-beancount', { 'for': 'beancount' }
Plug 'evanleck/vim-svelte', { 'for': 'svelte' }
Plug 'sheerun/vim-polyglot'
Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
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
set mouse=a

set guicursor=
set shortmess+=F

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

" Do not use tabs and use 4 spaces for indentation
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

set number
set undofile

set scrolloff=4

" So not abandon hidden buffers
set hidden
" highlight all search results
set hlsearch
" incremental search
set incsearch
" case-insensitive search
set ignorecase
" uppercase causes case-sensitive search
set smartcase
" apply substitutions globally by default
set gdefault
set inccommand=split

"set clipboard=unnamed
" }}}
" Key bindings {{{
nnoremap <Space> za
vnoremap <Space> za
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
" }}}
" Run tests {{{
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
" }}}
" }}}
" Completion {{{
nmap <silent> K <Plug>(ale_hover)
nmap <silent> gd <Plug>(ale_go_to_definition)
nnoremap <silent> <F2> :call ALERename<CR>

let g:deoplete#enable_at_startup = 1

let g:UltiSnipsSnippetDirectories = [$HOME.'/dev/dotfiles/snippets']
let g:UltiSnipsExpandTrigger       = '<C-j>'
let g:UltiSnipsJumpForwardTrigger  = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"
" }}}
" Misc {{{
let g:gutentags_cache_dir = $XDG_CACHE_HOME . '/nvim/tags'
let g:gutentags_ctags_exclude = ['/usr/local']
let g:gutentags_file_list_command = {
            \ 'markers': {
            \ '.git': 'git ls-files',
            \ '.hg': 'hg files',
            \ },
            \ }

set viewoptions=cursor,folds,slash,unix

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠'
let g:ale_sign_column_always = 1

let g:colorizer_auto_filetype='css'

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
\   'zsh': ['shellcheck', 'shell'],
\}
let g:ale_fixers = {
\   '*': ['prettier', 'eslint'],
\   'javascript': ['prettier', 'eslint'],
\   'javascriptreact': ['prettier', 'eslint', 'standard'],
\   'python': ['black'],
\   'svelte': ['prettier', 'eslint'],
\   'typescript': ['prettier'],
\}
" Javascript, CSS, SCSS {{{
augroup filetypes
    autocmd!
    autocmd FileType vim setlocal sw=4 sts=4
    autocmd FileType javascript setlocal sw=2 sts=2 fdm=syntax
    autocmd FileType javascriptreact setlocal sw=2 sts=2 fdm=syntax
    autocmd FileType typescript setlocal sw=2 sts=2 fdm=syntax
    autocmd FileType typescriptreact setlocal sw=2 sts=2 fdm=syntax
    autocmd FileType vue setlocal sw=2 sts=2
    autocmd FileType svelte setlocal sw=2 sts=2
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
" Mail {{{
autocmd filetypes FileType mail setlocal fo+=aw
"autocmd FileType mail Goyo
" }}}
" Latex {{{
" Better syntax hightlighting
let g:tex_flavor='latex'

let g:vimtex_compiler_latexmk = {
            \ 'build_dir': expand($HOME . '/.cache/latex-build'),
            \ }
let g:vimtex_fold_enabled = 1
let g:vimtex_motion_enabled = 1
let g:vimtex_matchparen_enabled = 0

let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_imaps_list = []

" call deoplete#custom#var('omni', 'input_patterns', {
"             \ 'tex': g:vimtex#re#deoplete
"             \})

augroup vimtex_config
    autocmd!
    autocmd User VimtexEventInitPost VimtexCompile
augroup END
" }}}
" Python {{{
augroup python
    autocmd!
    autocmd FileType python nnoremap <leader>i :ImportName<CR>
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

" call deoplete#enable_logging('INFO', '/Users/jakob/deoplete')
" call deoplete#custom#var('omni', 'input_patterns', {
"             \ 'beancount': '^\s+.*|#\S*|"[^"]*'
"             \})

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
