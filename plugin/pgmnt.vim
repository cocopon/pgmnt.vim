let s:save_cpo = &cpoptions
set cpoptions&vim


if exists('g:loaded_pgmnt') && g:loaded_pgmnt
  finish
endif


command! -nargs=0 PgmntDevInspect call pgmnt#dev#inspect()


let g:loaded_pgmnt = 1


let &cpoptions = s:save_cpo
