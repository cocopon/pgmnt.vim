let s:save_cpo = &cpoptions
set cpoptions&vim


function! pgmnt#color#rgb(r, g, b) abort
  return printf(
        \   '#%02x%02x%02x',
        \   float2nr(a:r),
        \   float2nr(a:g),
        \   float2nr(a:b)
        \ )
endfunction


function! s:constrain(value, min, max) abort
  return (a:value < a:min)
        \ ? a:min
        \ : (a:value > a:max)
        \ ? a:max
        \ : a:value
endfunction


function! s:hoge(comp, min, max) abort
  let c = a:comp
  let result = 0.0

  if c >= 0.0 && c < 60.0
    let result = a:min + (a:max - a:min) * c / 60.0
  elseif c >= 60.0 && c < 180.0
    let result = a:max
  elseif c >= 180.0 && c < 240.0
    let result = a:min + (a:max - a:min) * (240.0 - c) / 60.0
  else
    let result = a:min
  endif

  return result * 255.0
endfunction


function! s:hex_to_rgb_comps(hex) abort
  let results = matchlist(
        \   a:hex,
        \   '^#\(\x\x\)\(\x\x\)\(\x\x\)'
        \ )
  return [
        \   str2nr(results[1], 16) * 1.0,
        \   str2nr(results[2], 16) * 1.0,
        \   str2nr(results[3], 16) * 1.0,
        \ ]
endfunction


function! s:rgb_comps_to_hsl_comps(rgb_comps) abort
  let r = s:constrain(a:rgb_comps[0] / 255.0, 0.0, 1.0)
  let g = s:constrain(a:rgb_comps[1] / 255.0, 0.0, 1.0)
  let b = s:constrain(a:rgb_comps[2] / 255.0, 0.0, 1.0)

  let max = (r > g) ? r : g
  let max = (max > b) ? max : b
  let min = (r < g) ? r : g
  let min = (min < b) ? min : b
  let c = max - min
  let h = 0.0
  let s = 0.0
  let l = (min + max) / 2.0

  if c != 0.0
    let s = (l > 0.5) ? (c / (2 - min - max)) : (c / (max + min))

    if r == max
      let h = (g - b) / c
    elseif g == max
      let h = 2.0 + (b - r) / c
    elseif b == max
      let h = 4.0 + (r - g) / c
    endif

    let h = h / 6.0 + ((h < 0) ? 1.0 : 0.0)
  endif

  return [h * 360.0, s, l]
endfunction


function! pgmnt#color#hsl(h, s, l) abort
  let h = s:constrain(a:h * 1.0, 0.0, 360.0)
  let s = s:constrain(a:s * 1.0, 0.0, 1.0)
  let l = s:constrain(a:l * 1.0, 0.0, 1.0)
  let max = (l <= 0.5)
        \ ? (l * (1.0 + s))
        \ : (l * (1.0 - s) + s)
  let min = 2.0 * l - max

  let hh = h + 120.0
  if hh >= 360.0
    let hh -= 360.0
  endif
  let r = s:hoge(hh, min, max)

  let hh = h
  if hh >= 360.0
    let hh = 0.0
  endif
  let g = s:hoge(hh, min, max)

  let hh = h - 120.0
  if hh < 0.0
    let hh += 360.0
  endif
  let b = s:hoge(hh, min, max)

  return pgmnt#color#rgb(r, g, b)
endfunction


function! pgmnt#color#adjust_color(hex, options) abort
  let hsl_comps = s:rgb_comps_to_hsl_comps(
        \   s:hex_to_rgb_comps(a:hex)
        \ )
  return pgmnt#color#hsl(
        \   hsl_comps[0] + get(a:options, 'hue', 0),
        \   hsl_comps[1] + get(a:options, 'saturation', 0),
        \   hsl_comps[2] + get(a:options, 'lightness', 0)
        \ )
endfunction


function! pgmnt#color#darken(hex, amount) abort
  let hsl_comps = s:rgb_comps_to_hsl_comps(
        \   s:hex_to_rgb_comps(a:hex)
        \ )
  return pgmnt#color#hsl(
        \   hsl_comps[0],
        \   hsl_comps[1],
        \   hsl_comps[2] - a:amount
        \ )
endfunction


function! pgmnt#color#lighten(hex, amount) abort
  let hsl_comps = s:rgb_comps_to_hsl_comps(
        \   s:hex_to_rgb_comps(a:hex)
        \ )
  return pgmnt#color#hsl(
        \   hsl_comps[0],
        \   hsl_comps[1],
        \   hsl_comps[2] + a:amount
        \ )
endfunction


function! pgmnt#color#mix(hex1, hex2, weight) abort
  let rgb_comps1 = s:hex_to_rgb_comps(a:hex1)
  let rgb_comps2 = s:hex_to_rgb_comps(a:hex2)
  let w1 = a:weight
  let w2 = 1.0 - a:weight
  return pgmnt#color#rgb(
        \   rgb_comps1[0] * w1 + rgb_comps2[0] * w2,
        \   rgb_comps1[1] * w1 + rgb_comps2[1] * w2,
        \   rgb_comps1[2] * w1 + rgb_comps2[2] * w2
        \ )
endfunction


let &cpoptions = s:save_cpo
