let s:save_cpo = &cpoptions
set cpoptions&vim


function! pgmnt#dev#inspect() abort
  let synid = synID(line('.'), col('.'), 1)
  let names = exists(':ColorSwatchGenerate')
        \ ? s:hi_chain_with_colorswatch(synid)
        \ : s:hi_chain(synid)
  echo join(names, ' -> ')
endfunction


function! s:hi_chain(synid) abort
  let name = synIDattr(a:synid, 'name')
  let names = []

  call add(names, name)

  let original = synIDtrans(a:synid)
  if a:synid != original
    call add(names, synIDattr(original, 'name'))
  endif

  return names
endfunction


" Trace hi-group link with colorswatch.vim.
" (It can show more detailed information)
function! s:hi_chain_with_colorswatch(synid) abort
  let entries = colorswatch#source#all#collect()
  let entryset = colorswatch#entryset#new(entries)

  let name = synIDattr(a:synid, 'name')
  let entry = entryset.find_entry(name)
  let names = []

  while !empty(entry)
    let name = entry.get_name()
    call add(names, name)

    if !entry.has_link()
      break
    endif

    let entry = entryset.find_entry(entry.get_link())
  endwhile

  return names
endfunction


let &cpoptions = s:save_cpo
