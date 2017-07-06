function! fish#Indent()
  if !exists('g:the_indent')
    let g:the_indent = 0
  endif

  let l:prevlnum = prevnonblank(v:lnum - 1)
  if l:prevlnum ==# 0
    return 0
  endif
  let l:indent = 0
  let l:prevline = getline(l:prevlnum)
  if l:prevline =~# '\v^\s*%(begin|if|else|while|for|function|case)>'
    let l:indent = &shiftwidth
  endif

  let l:line = getline(v:lnum)

  if l:line =~# '\v^\s*switch>'
    let g:the_indent = 1
  elseif l:line =~# '\v^\s*%(begin|if|while|for|function)>'
    let g:the_indent += 1
  elseif l:line =~# '\v^\s*end>'
    if g:the_indent > 1
      let g:the_indent -= 1
    elseif g:the_indent == 1
      let g:the_indent = 0
      return indent(l:prevlnum) + l:indent - &shiftwidth * 2
    endif
    return indent(l:prevlnum) + l:indent - &shiftwidth
  elseif l:line =~# '\v^\s*%(case|else)>'
    return indent(l:prevlnum) - &shiftwidth
  endif
  return indent(l:prevlnum) + l:indent
endfunction

setlocal indentexpr=fish#Indent()
setlocal indentkeys+==end,=else,=case
