set nocompatible

" Filesystem paths
let $MYVIMRC = expand('<sfile>:p')
let $VIMDOTDIR = expand('<sfile>:p:h')
let &runtimepath .= "," . $VIMDOTDIR

" System temporary files
if !exists('$TEMP')
  let $TEMP = '/tmp'
endif

" Backups and swap files
set directory=$VIMDOTDIR/cache,/tmp,/var/tmp,$TEMP
set backupdir=$VIMDOTDIR/cache,/tmp,/var/tmp,$TEMP

" Appropriate path for viminfo
if has('viminfo')
  if !exists('$VIMINFO')
    let $VIMINFO = $VIMDOTDIR . "/viminfo"
  endif
endif
"
" Viminfo file behavior
if has('viminfo')
  " f1  store file marks
  " '   # of previously edited files to remember marks for
  " :   # of lines of command history
  " /   # of lines of search pattern history
  " <   max # of lines for each register to be saved
  " s   max # of Kb for each register to be saved
  " h   don't restore hlsearch behavior
  let &viminfo = "f1,'1000,:1000,/1000,<1000,s100,h,r" . $TEMP . ",n" . $VIMINFO
endif

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

Plug 'lervag/vimtex'
Plug 'tpope/vim-surround'
Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'klen/python-mode'
Plug 'ledger/vim-ledger'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/goyo.vim'

call plug#end()

syntax enable
colorscheme solarized
set background=dark

" Do not use tabs and use 4 spaces for indentation
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

set autoindent
set nobackup
set number
set wrap
set backspace=2

" So not abandon hidden buffers
set hidden

" Make search use normal regex
set hlsearch       " highlight all search results
set incsearch      " increment search
set ignorecase     " case-insensitive search
set smartcase      " uppercase causes case-sensitive search
set gdefault       " apply substitutions globally by default
" Clear search highlights easily
nnoremap <leader><space> :noh<cr>

" Move up/down by on-screen lines
nnoremap j gj
nnoremap k gk

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

" For VIM help files
nnoremap <silent> coc
      \ :set conceallevel=<C-r>=&conceallevel == 2 ? 0 : 2<CR><CR>
      \ :set conceallevel?<CR>

" Make python formatting adhere to pep8
au FileType python setlocal formatprg=autopep8\ -
let g:pymode_rope=0

" Settings for latex files
let g:vimtex_latexmk_build_dir=expand("$HOME/.cache/latex-build")
let g:tex_flavor='latex'               " Better syntax hightlighting
autocmd FileType tex set tw=80         " wrap at 80 chars for LaTeX files
if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
      \ 're!\\[A-Za-z]*(ref|cite)[A-Za-z]*([^]]*])?{([^}]*, ?)*'
      \ ]

" Set powerline fonts and always display it
let g:airline_powerline_fonts = 1
set laststatus=2

" Make ultisnips compatible with YouCompleteMe
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

let g:ledger_maxwidth = 120
let g:ledger_fold_blanks = 1
nnoremap <leader>t :call ledger#transaction_state_toggle(line('.'), '*?!')<CR>
nnoremap <leader>c :call ledger#transaction_state_set(line('.'), '*')<CR>

" Make :q work in Goyo
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
