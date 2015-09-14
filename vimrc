" vim: set foldmethod=marker:
set nocompatible

" Paths {{{
" Filesystem paths
let $MYVIMRC = expand('<sfile>:p')
let $VIMDOTDIR = expand('<sfile>:p:h')
let &runtimepath .= "," . $VIMDOTDIR

" System temporary files
if !exists('$TEMP')
  let $TEMP = '/tmp'
endif

" Backups and swap files
set directory=$VIMDOTDIR/cache
set backupdir=$VIMDOTDIR/cache
set undodir=$VIMDOTDIR/cache
set viewdir=$VIMDOTDIR/view

if !isdirectory(&undodir)
    call mkdir(&undodir)
endif

" Appropriate path for viminfo
if !exists('$VIMINFO')
  let $VIMINFO = $VIMDOTDIR . "/viminfo"
endif
let &viminfo = "f1,'1000,:1000,/1000,<1000,s100,h,r" . $TEMP . ",n" . $VIMINFO
" }}}

" Plugins {{{
if empty(glob('$VIMDOTDIR/autoload/plug.vim'))
  silent !echo "Installing vim-plug..."
  silent !curl -fLo $VIMDOTDIR/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.sh
  endif
endfunction

call plug#begin("$VIMDOTDIR/plugged")

Plug 'bling/vim-airline'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-fnr'
Plug 'junegunn/vim-oblique'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'kopischke/vim-stay'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
"
" File type specific plugins
Plug 'klen/python-mode'
Plug 'ledger/vim-ledger'
Plug 'lervag/vimtex'
Plug 'plasticboy/vim-markdown'
Plug 'nathangrigg/vim-beancount'

" Color schemes
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'
Plug 'junegunn/seoul256.vim'
Plug 'jceb/vim-orgmode'

call plug#end()
" }}}

" Basic settings {{{
syntax enable
colorscheme solarized
set background=dark

" Do not use tabs and use 4 spaces for indentation
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

set autoindent
set relativenumber
set number
set backspace=2
set undofile

set scrolloff=4

set hidden         " So not abandon hidden buffers
set hlsearch       " highlight all search results
set incsearch      " increment search
set ignorecase     " case-insensitive search
set smartcase      " uppercase causes case-sensitive search
set gdefault       " apply substitutions globally by default
" }}}

" Key bindings {{{
nnoremap <Space> za       " Space toggles folds
vnoremap <Space> za

nnoremap <leader><space> :noh<cr>  " Clear search highlights easily
" Move up/down by on-screen lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
" Save one keystroke for commmands
inoremap jk <ESC>
" Quicker window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
if has('nvim')
    nmap <BS> <C-W>h
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
endif
noremap <tab> %

nnoremap U :UndotreeToggle<CR>
nnoremap <silent> <leader><leader> :FZF -m<cr>
nmap <F8> :TagbarToggle<CR>
let g:easytags_file = $VIMDOTDIR . '/tags'
" }}}

" vim-stay {{{
set viewoptions=cursor,folds,slash,unix
" }}}

" For VIM help files {{{
nnoremap <silent> coc
      \ :set conceallevel=<C-r>=&conceallevel == 2 ? 0 : 2<CR><CR>
      \ :set conceallevel?<CR>
" }}}

" Python settings {{{
au FileType python setlocal formatprg=autopep8\ -
let g:pymode_rope=0
" }}}

" Latex settings {{{
let g:vimtex_latexmk_build_dir=expand("$HOME/.cache/latex-build")
let g:tex_flavor='latex'               " Better syntax hightlighting
if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
      \ 're!\\[A-Za-z]*(ref|cite)[A-Za-z]*([^]]*])?{([^}]*, ?)*'
      \ ]
" }}}

" Airline {{{
let g:airline_powerline_fonts = 1
set laststatus=2
" }}}

" Make ultisnips compatible with YouCompleteMe {{{
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" }}}

" Make :q work in Goyo"{{{
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
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

" Custom folding for beancount according to Markdown-style headings {{{
autocmd FileType beancount call Beancount()
autocmd FileType beancount SpeedDatingFormat %Y-%m-%d
nnoremap <leader>t :call ledger#transaction_state_toggle(line('.'), '*!')<CR>

function! Beancount()
    function! BeancountFold(lnum)
        let l1 = getline(a:lnum)
        if l1 =~ '^#'
            return '>'.match(l1, '[^#]')
        elseif match(l1, '[!*]')>0
            return '>3'
        endif
        return '='
    endfunction
    setlocal foldmethod=expr
    setlocal foldexpr=BeancountFold(v:lnum)
endfunction
" }}}
