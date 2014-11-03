set nocompatible
filetype off

" Filesystem paths
let $MYVIMRC = expand('<sfile>:p')
let $VIMDOTDIR = expand('<sfile>:p:h')
let &runtimepath .= "," . $VIMDOTDIR

if !exists('$XDG_CACHE_HOME')
  let $XDG_CACHE_HOME = $HOME . "/.cache"
endif

if !isdirectory(expand('$XDG_CACHE_HOME'))
  call mkdir(expand('$XDG_CACHE_HOME'))
endif

if !isdirectory(expand('$XDG_CACHE_HOME/vim'))
  call mkdir(expand('$XDG_CACHE_HOME/vim'))
endif

" System temporary files
if !exists('$TEMP')
  let $TEMP = '/tmp'
endif

" Backups and swap files
set directory=$XDG_CACHE_HOME/vim,/tmp,/var/tmp,$TEMP
set backupdir=$XDG_CACHE_HOME/vim,/tmp,/var/tmp,$TEMP

" Appropriate path for viminfo
if has('viminfo')
  if !exists('$VIMINFO')
    let $VIMINFO = $VIMDOTDIR . "/viminfo"
  endif
endif

let run_bundle_install = 0

if !isdirectory(expand("$VIMDOTDIR/bundle/vundle/"))
  silent !echo "Installing Vundle..."
  silent !mkdir -p ~$VIMDOTDIR/bundle
  silent !git clone https://github.com/gmarik/vundle $VIMDOTDIR/bundle/vundle
  let run_bundle_install = 1
endif

" Bundle setup
let &runtimepath .= "," . $VIMDOTDIR . "/bundle/vundle"
call vundle#rc("$VIMDOTDIR/bundle")

" the plug-in manager for Vim
Plugin 'gmarik/vundle'
