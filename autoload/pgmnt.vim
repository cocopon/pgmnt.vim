let s:save_cpo = &cpoptions
set cpoptions&vim


function! pgmnt#compile(context, options) abort
	let template_lines = readfile(a:options['template'])

	let result_lines = pgmnt#template#render(
				\ 	template_lines,
				\ 	a:context
				\ )

	if has_key(a:options, 'output')
		call writefile(result_lines, a:options['output'])
	else
		echo join(result_lines, "|")
	endif
endfunction


let &cpoptions = s:save_cpo
