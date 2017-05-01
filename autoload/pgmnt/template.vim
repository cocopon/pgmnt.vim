let s:save_cpo = &cpoptions
set cpoptions&vim


function! s:render_value(context, key) abort
	let value = get(a:context, a:key, '')
	return (type(value) == type([]))
				\ ? join(value, "\n")
				\ : value
endfunction


function! pgmnt#template#render(template_lines, context) abort
	let rendered_lines = []

	for template_line in a:template_lines
		let rendered_line = substitute(
					\ 	template_line,
					\ 	'{{\s*\(\S\{-1,\}\)\s*}}',
					\ 	{matches -> s:render_value(a:context, get(matches, 1, ''))},
					\ 	'g'
					\ )
		let rendered_sublines = split(rendered_line, "\n")

		if !empty(rendered_sublines)
			call extend(
						\ 	rendered_lines,
						\ 	rendered_sublines
						\ )
		else
			" extend() does nothing with extending empty list
			call add(rendered_lines, '')
		endif
	endfor

	return rendered_lines
endfunction


let &cpoptions = s:save_cpo
