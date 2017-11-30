let s:suite = themis#suite('pgmnt#color')
let s:assert = themis#helper('assert')


function! s:suite.test_render_inline() 
  let template = [
        \   '  hello {{ name }}!',
        \ ]
  let context = {
        \   'name': 'pgmnt',
        \ }
  let expected = [
        \   '  hello pgmnt!',
        \ ]
  call s:assert.equals(
        \   pgmnt#template#render(template, context),
        \   expected
        \ )
endfunction


function! s:suite.test_render_multiple() 
  let template = [
        \   'from {{ source }} to {{ destination }}',
        \ ]
  let context = {
        \   'source': 'me',
        \   'destination': 'you',
        \ }
  let expected = [
        \   'from me to you',
        \ ]
  call s:assert.equals(
        \   pgmnt#template#render(template, context),
        \   expected
        \ )
endfunction


function! s:suite.test_render_blank_lines() 
  let template = [
        \   'header',
        \   '',
        \   'separator',
        \   '',
        \   '',
        \   'footer',
        \ ]
  let context = {
        \   'items': ['foo', 'bar', 'baz'],
        \ }
  call s:assert.equals(
        \   pgmnt#template#render(template, context),
        \   template
        \ )
endfunction


function! s:suite.test_render_array() 
  let template = [
        \   'header',
        \   '{{ items }}',
        \   'footer',
        \ ]
  let context = {
        \   'items': ['foo', 'bar', 'baz'],
        \ }
  let expected = [
        \   'header',
        \   'foo',
        \   'bar',
        \   'baz',
        \   'footer',
        \ ]
  call s:assert.equals(
        \   pgmnt#template#render(template, context),
        \   expected
        \ )
endfunction


function! s:suite.test_render_space() 
  let template = [
        \   '{{ space }}',
        \   '{{nospace}}',
        \ ]
  let context = {
        \   'space': 'foo',
        \   'nospace': 'bar',
        \ }
  let expected = [
        \   'foo',
        \   'bar',
        \ ]
  call s:assert.equals(
        \   pgmnt#template#render(template, context),
        \   expected
        \ )
endfunction


function! s:suite.test_render_indented_list()
  let template = [
        \   '  {{items}}',
        \   '	{{items}}',
        \ ]
  let context = {
        \   'items': ['foo', 'bar'],
        \ }
  let expected = [
        \   '  foo',
        \   '  bar',
        \   '	foo',
        \   '	bar',
        \ ]
  call s:assert.equals(
        \   pgmnt#template#render(template, context),
        \   expected
        \ )
endfunction


function! s:suite.test_render_doubled_list()
  let template = [
        \   '  {{items}} {{items}}',
        \ ]
  let context = {
        \   'items': ['foo', 'bar'],
        \ }
  let expected = [
        \   '  foo',
        \   '  bar foo',
        \   'bar',
        \ ]
  call s:assert.equals(
        \   pgmnt#template#render(template, context),
        \   expected
        \ )
endfunction
