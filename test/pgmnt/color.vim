let s:suite = themis#suite('pgmnt#color')
let s:assert = themis#helper('assert')


function! s:suite.test_rgb() 
  call s:assert.equals(
        \   pgmnt#color#rgb(0, 136, 255),
        \   '#0088ff'
        \ )
endfunction


function! s:suite.test_hsl() 
  call s:assert.equals(
        \   pgmnt#color#hsl(0, 0, 0),
        \   '#000000'
        \ )
  call s:assert.equals(
        \   pgmnt#color#hsl(0, 0, 0.5),
        \   '#7f7f7f'
        \ )
  call s:assert.equals(
        \   pgmnt#color#hsl(0, 0, 1.0),
        \   '#ffffff'
        \ )
  call s:assert.equals(
        \   pgmnt#color#hsl(-10, -20, -30),
        \   '#000000'
        \ )
  call s:assert.equals(
        \   pgmnt#color#hsl(240, 1.0, 0.5),
        \   '#0000ff'
        \ )
  call s:assert.equals(
        \   pgmnt#color#hsl(160, 0.25, 0.75),
        \   '#afcfc4'
        \ )
endfunction


function! s:suite.test_darken()
  call s:assert.equals(
        \   pgmnt#color#darken('#daf5a3', 0.2),
        \   '#b5eb47'
        \   )
  call s:assert.equals(
        \   pgmnt#color#darken('#daf5a3', 9999.0),
        \   '#000000'
        \ )
endfunction

function! s:suite.test_lighten()
  call s:assert.equals(
        \   pgmnt#color#lighten('#daf5a3', 0.1),
        \   '#ecfad1'
        \ )
  call s:assert.equals(
        \   pgmnt#color#lighten('#daf5a3', 9999.0),
        \   '#ffffff'
        \ )
endfunction


function! s:suite.test_adjust_color()
  call s:assert.equals(
        \   pgmnt#color#adjust_color(
        \     '#daf5a3', {
        \       'hue': 30,
        \     }
        \   ),
        \   '#b1f5a3'
        \ )
  call s:assert.equals(
        \   pgmnt#color#adjust_color(
        \     '#daf5a3', {
        \       'saturation': -0.1,
        \     }
        \   ),
        \   '#d8efa8'
        \ )
  call s:assert.equals(
        \   pgmnt#color#adjust_color(
        \     '#daf5a3', {
        \       'lightness': -0.2,
        \     }
        \   ),
        \   '#b5eb47'
        \ )
endfunction


function! s:suite.test_mix()
  call s:assert.equals(
        \   pgmnt#color#mix(
        \     '#ff0000', '#00ff00',
        \     0.25
        \   ),
        \   '#3fbf00'
        \ )
  call s:assert.equals(
        \   pgmnt#color#mix(
        \     '#123456', '#789abc',
        \     0.75
        \   ),
        \   '#2b4d6f'
        \ )
endfunction
