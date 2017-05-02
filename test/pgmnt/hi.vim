let s:suite = themis#suite('pgmnt#color')
let s:assert = themis#helper('assert')


function! s:suite.test_hi_group()
  let attrs = {
        \   'ctermfg': 123,
        \   'gui': 'underline',
        \   'guifg': '#123456',
        \ }
  call s:assert.equals(
        \   pgmnt#hi#group('group', attrs),
        \   ['hi! group ctermfg=123 gui=underline guifg=#123456']
        \ )
  call s:assert.equals(
        \   pgmnt#hi#group(['groupA', 'groupB'], attrs),
        \   [
        \     'hi! groupA ctermfg=123 gui=underline guifg=#123456',
        \     'hi! groupB ctermfg=123 gui=underline guifg=#123456',
        \   ]
        \ )
endfunction


function! s:suite.test_hi_link()
  call s:assert.equals(
        \   pgmnt#hi#link('groupA', 'groupB'),
        \   'hi! link groupA groupB'
        \ )
endfunction
