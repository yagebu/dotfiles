" vim: set foldmethod=marker:
" Directories {{{
set backupdir-=.
if !isdirectory(&backupdir)
  call mkdir(&backupdir, "p")
endif
" }}}
" Plugins {{{
" setup {{{
if empty(glob('$XDG_DATA_HOME/nvim/site/autoload/plug.vim'))
  silent !echo "Installing vim-plug..."
  silent !curl -fLo $XDG_DATA_HOME/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin("$XDG_DATA_HOME/nvim/plugged")
" }}}
Plug 'itchyny/lightline.vim'
"Plug 'honza/vim-snippets'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vader.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-fnr'
Plug 'junegunn/vim-oblique'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-pseudocl'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'jreybert/vimagit'
Plug 'Konfekt/FastFold'
Plug 'kopischke/vim-stay'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'w0rp/ale'
"Plug 'SirVer/ultisnips'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" File type specific plugins
Plug 'chrisbra/Colorizer', { 'for': ['css', 'scss'] }
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'mitsuhiko/vim-jinja'
Plug 'lervag/vimtex', { 'for': ['tex', 'latex'] }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'ledger/vim-ledger', { 'for': 'beancount' }
Plug 'nathangrigg/vim-beancount'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'othree/yajs.vim', { 'for': 'javascript' }
"Plug 'tweekmonster/nvimdev.nvim'
function InstallTern()
    let s:uname = system('uname -s')
    if s:uname == 'Darwin'
        system('npm install -g tern')
    endif
endfunction
Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript', 'do': function('InstallTern') }

" Color schemes
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'

call plug#end()
" }}}
" Basic settings {{{
set termguicolors
colorscheme gruvbox
set background=dark

set gcr=
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1
set shm+=F

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
nnoremap <silent> <leader><Enter>  :Buffers<cr>
nnoremap <silent> <leader>a  :Ag<cr>
nnoremap <silent> <leader>g  :Goyo<cr>
nnoremap <silent> <leader>h  :Helptags<cr>
nnoremap <silent> <F8> :TagbarToggle<cr>

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

nnoremap <silent> coc
      \ :set conceallevel=<C-r>=&conceallevel == 2 ? 0 : 2<CR><CR>
      \ :set conceallevel?<CR>
" }}}
" Completion {{{
let g:deoplete#enable_at_startup = 1
"let g:deoplete#enable_at_startup = 0
"autocmd InsertEnter * call deoplete#enable()
"inoremap <silent><expr><C-Space> deoplete#mappings#manual_complete()
autocmd CompleteDone * pclose!

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" }}}
" Misc {{{
let g:gutentags_cache_dir = $XDG_CACHE_HOME . '/nvim/tags'
let g:gutentags_ctags_exclude = ['/usr/local']
"let g:gutentags_ctags_executable = 'ctags --python-kinds=-i'

set viewoptions=cursor,folds,slash,unix

let g:limelight_conceal_guifg = '#999999'

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠'
let g:ale_sign_column_always = 1

let g:colorizer_auto_filetype='css,scss'
autocmd BufWritePost */dev/dotfiles/* silent !~/dev/dotfiles/install > /dev/null
" }}}
" File types {{{
" Javascript, CSS, SCSS {{{
au FileType javascript setlocal sw=2 sts=2 fdm=syntax
au FileType css setlocal sw=2 sts=2
au FileType scss setlocal sw=2 sts=2
au FileType html setlocal sw=2 sts=2
au FileType htmljinja setlocal sw=2 sts=2
" }}}
" C, Lua {{{
au FileType c setlocal sw=2 sts=2
au FileType lua setlocal sw=2 sts=2
" }}}
" Markdown {{{
au FileType markdown nmap gm :LivedownToggle<CR>
let g:vim_markdown_folding_style_pythonic = 1
" }}}
" Mail {{{
au FileType mail setlocal fo+=aw
"au FileType mail Goyo
" }}}
" Latex {{{
au FileType tex setlocal norelativenumber
let g:vimtex_compiler_latexmk = {
      \ 'build_dir': expand("$HOME/.cache/latex-build"),
      \ }
let g:tex_flavor='latex'               " Better syntax hightlighting

let g:deoplete#omni#input_patterns.tex = '\\(?:'
      \ .  '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
      \ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
      \ . '|hyperref\s*\[[^]]*'
      \ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
      \ . '|(?:include(?:only)?|input)\s*\{[^}]*'
      \ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
      \ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
      \ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
      \ .')'

let g:vimtex_fold_enabled = 1
let g:vimtex_motion_enabled = 1
let g:vimtex_matchparen_enabled = 0

let g:vimtex_view_method = 'skim'
let g:vimtex_compiler_progname = 'nvr'

augroup vimtex_config
    au!
    au User VimtexEventInitPost VimtexCompile
augroup END
" }}}
" Beancount (with custom org-mode folding) {{{
autocmd FileType beancount call Beancount()
autocmd FileType beancount SpeedDatingFormat %Y-%m-%d
nnoremap <leader>t :call ledger#transaction_state_toggle(line('.'), '*!')<CR>

"call deoplete#enable_logging('INFO', '/Users/jakob/deoplete')
" let g:deoplete#omni#input_patterns.beancount = '^\s+.*|#\S*|"[^"]*'
autocmd FileType beancount inoremap . .<C-\><C-O>:AlignCommodity<CR>

function! Beancount()
    function! BeancountFold(lnum)
        let l1 = getline(a:lnum)
        if l1 =~ '^*'
            return '>'.match(l1, '[^*]')
        endif
        return '='
    endfunction
    setlocal foldmethod=expr
    setlocal foldexpr=BeancountFold(v:lnum)
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
" Make :q work in Goyo {{{
function! s:goyo_enter()
  Limelight
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  Limelight!
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd User GoyoEnter call <SID>goyo_enter()
autocmd User GoyoLeave call <SID>goyo_leave()
" }}}
" Terminal colors {{{
" dark0 + gray
let g:terminal_color_0 = "#282828"
let g:terminal_color_8 = "#928374"

" neurtral_red + bright_red
let g:terminal_color_1 = "#cc241d"
let g:terminal_color_9 = "#fb4934"

" neutral_green + bright_green
let g:terminal_color_2 = "#98971a"
let g:terminal_color_10 = "#b8bb26"

" neutral_yellow + bright_yellow
let g:terminal_color_3 = "#d79921"
let g:terminal_color_11 = "#fabd2f"

" neutral_blue + bright_blue
let g:terminal_color_4 = "#458588"
let g:terminal_color_12 = "#83a598"

" neutral_purple + bright_purple
let g:terminal_color_5 = "#b16286"
let g:terminal_color_13 = "#d3869b"

" neutral_aqua + faded_aqua
let g:terminal_color_6 = "#689d6a"
let g:terminal_color_14 = "#8ec07c"

" light4 + light1
let g:terminal_color_7 = "#a89984"
let g:terminal_color_15 = "#ebdbb2"
