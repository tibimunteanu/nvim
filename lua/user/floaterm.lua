vim.cmd([[
  let g:floaterm_width=0.9
  let g:floaterm_height=0.7
  let g:floaterm_title=' Terminal $1 / $2 '
  let g:floaterm_borderchars='─│─│╭╮╯╰'

  " 0: keep open, 1: close on success, 2: always close
  let g:floaterm_autoclose=2
]])
