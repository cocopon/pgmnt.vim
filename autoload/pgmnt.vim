let s:save_cpo = &cpoptions
set cpoptions&vim


function! pgmnt#compile(context, options) abort
  let template_lines = readfile(a:options['template'])

  let result_lines = pgmnt#template#render(
        \   template_lines,
        \   a:context
        \ )

  if has_key(a:options, 'output')
    let output_path = a:options['output']
    call writefile(result_lines, output_path)
    if get(g:, 'pgmnt_auto_source', 0)
      execute printf('source %s', 
            \ fnameescape(output_path))
    endif
  else
    vnew
    call append(0, result_lines)
  endif
endfunction


let &cpoptions = s:save_cpo
