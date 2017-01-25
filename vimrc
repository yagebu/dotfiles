" vim: set foldmethod=marker:
" Directories {{{
set backupdir-=.
if !isdirectory(&backupdir)
  call mkdir(&backupdir, "p")
endif
" }}}
" Plugins {{{
" setup {{{
if empty(glob('$XDG_CONFIG_HOME/nvim/autoload/plug.vim'))
  silent !echo "Installing vim-plug..."
  silent !curl -fLo $XDG_CONFIG_HOME/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin("$XDG_DATA_HOME/nvim/plugged")
" }}}
Plug 'bling/vim-airline'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/rainbow_parentheses.vim'
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
Plug 'neomake/neomake'
Plug 'SirVer/ultisnips'
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
Plug 'nathangrigg/vim-beancount', { 'for': 'beancount' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript', 'do': 'npm install -g tern' }

" Color schemes
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'

call plug#end()
" }}}
" Basic settings {{{
set termguicolors
colorscheme gruvbox
set background=dark

let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1

" Do not use tabs and use 4 spaces for indentation
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

set relativenumber
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
inoremap <silent><expr><C-Space> deoplete#mappings#manual_complete()
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
let g:gutentags_exclude = ['/usr/local']
"let g:gutentags_ctags_executable = 'ctags --python-kinds=-i'

set viewoptions=cursor,folds,slash,unix

let g:limelight_conceal_guifg = '#999999'

autocmd BufEnter,BufWritePost * Neomake

let g:colorizer_auto_filetype='css,scss'
autocmd BufWritePost */dev/dotfiles/* silent !fresh > /dev/null
" }}}
" File types {{{
" Javascript, CSS, SCSS {{{
au FileType javascript setlocal sw=2 sts=2 fdm=syntax
au FileType css setlocal sw=2 sts=2
au FileType scss setlocal sw=2 sts=2
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
let g:vimtex_latexmk_build_dir=expand("$HOME/.cache/latex-build")
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
let g:vimtex_motion_matchparen = 0
let g:vimtex_latexmk_progname = 'nvr'

let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '@line @pdf @tex'

let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
function! UpdateSkim(status)
  if !a:status | return | endif

  let l:out = b:vimtex.out()
  let l:tex = expand('%:p')
  let l:cmd = [g:vimtex_view_general_viewer, '-r']
  if !empty(system('pgrep Skim'))
    call extend(l:cmd, ['-g', line('.'), l:out, l:tex])
  endif
  if has('nvim')
    call jobstart(l:cmd + [line('.'), l:out, l:tex])
  elseif has('job')
    call job_start(l:cmd + [line('.'), l:out, l:tex])
  else
    call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
  endif
endfunction

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
autocmd FileType beancount inoremap . .<C-O>:AlignCommodity<CR>

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
" Airline {{{
set laststatus=2
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#tabline#enabled = 1
" }}}
" Make :q work in Goyo"{{{
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
