vim.cmd([[
  let g:scratch_filetype='markdown'
  let g:scratch_top=0
  let g:scratch_horizontal=1
  let g:scratch_height=0.5
  let g:scratch_persistence_file='~/.config/nvim/scratch.md'
  let g:scratch_no_mappings = 1

  augroup exitScratchOnEsc
    autocmd!
    autocmd FileType markdown,scratch nmap <esc> <C-w>k
  augroup end
]])
