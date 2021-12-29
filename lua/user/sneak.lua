-- TODO: migrate to lua
vim.cmd [[
  let g:sneak#label = 0

  " 2-character Sneak (default)
  nmap s <Plug>Sneak_s
  nmap S <Plug>Sneak_S
  " visual-mode
  xmap s <Plug>Sneak_s
  xmap S <Plug>Sneak_S
  " operator-pending-mode
  omap s <Plug>Sneak_s
  omap S <Plug>Sneak_S

  " repeat motion
  map ; <Plug>Sneak_;
  map , <Plug>Sneak_,

  " 1-character enhanced 'f'
  nmap f <Plug>Sneak_f
  nmap F <Plug>Sneak_F
  " visual-mode
  xmap f <Plug>Sneak_f
  xmap F <Plug>Sneak_F
  " operator-pending-mode
  omap f <Plug>Sneak_f
  omap F <Plug>Sneak_F

  " 1-character enhanced 't'
  nmap t <Plug>Sneak_t
  nmap T <Plug>Sneak_T
  " visual-mode
  xmap t <Plug>Sneak_t
  xmap T <Plug>Sneak_T
  " operator-pending-mode
  omap t <Plug>Sneak_t
  omap T <Plug>Sneak_T

  " label-mode
  nmap <leader>s <Plug>SneakLabel_s
  nmap <leader>S <Plug>SneakLabel_S
]]
