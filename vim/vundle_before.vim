set nocompatible
filetype off

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
