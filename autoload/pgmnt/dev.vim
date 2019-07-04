let s:save_cpo = &cpoptions
set cpoptions&vim


function! pgmnt#dev#inspect() abort
  echoerr ':PgmntDevInspect is deprecated. Use inspecthi.vim instead.'
endfunction


let &cpoptions = s:save_cpo
