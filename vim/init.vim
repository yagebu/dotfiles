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
