let s:save_cpo = &cpoptions
set cpoptions&vim


function! pgmnt#hi#group(name_or_names, attributes) abort
  let names = (type(a:name_or_names) == type([]))
        \ ? a:name_or_names
        \ : [a:name_or_names]

  let arg_keys = keys(a:attributes)
  call sort(arg_keys)
  let args = map(
        \   arg_keys,
        \   'v:val . "=" . a:attributes[v:val]'
        \ )
  let joined_args = join(args, ' ')

  return map(
        \   names,
        \   '"hi! " . v:val . " " . joined_args'
        \ )
endfunction


function! pgmnt#hi#link(group_from, group_to) abort
  return printf(
        \   'hi! link %s %s',
        \   a:group_from,
        \   a:group_to
        \ )
endfunction


let &cpoptions = s:save_cpo
