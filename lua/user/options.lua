-- stylua: ignore start
local options = {
  fileencoding = "utf-8",                  -- the encoding written to a file
  guifont = "monospace:h17",               -- the font used in graphical neovim applications

  termguicolors = true,                    -- set term gui colors (most terminals support this)

  mouse = "a",                             -- allow the mouse to be used in neovim
  --mousehide = true,
  --mousemodel = "extend",

  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard

  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window

  hlsearch = false,                        -- highlight all matches on previous search pattern
  incsearch = true,                        -- highlight as you search

  hidden = true,                           -- keep unsaved buffers in bg
  autoread = true,
  swapfile = false,                        -- creates a swapfile
  backup = false,                          -- creates a backup file
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  undofile = true,                         -- enable persistent undo
  --undodir="~./vim/undodir",

  wrap = false,                            -- display lines as one long line
  textwidth = 80,

  ignorecase = true,                       -- ignore case in search patterns
  smartcase = true,                        -- smart case

  tabstop = 2,                             -- insert 2 spaces for a tab
  softtabstop = 2,
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  shiftround = true,
  expandtab = true,                        -- convert tabs to spaces
  smartindent = true,                      -- make indenting smarter again

  number = true,                           -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines
  numberwidth = 1,                         -- set number column width
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time. or merge with "number" column.
  cursorline = false,                      -- highlight the current line

  scrolloff = 8,
  sidescrolloff = 8,

  errorbells = false,
  ruler = false,
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showcmd = true,
  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  timeoutlen = 1000,                       -- time to wait for a mapped sequence to complete (in milliseconds)
  updatetime = 50,                         -- faster completion (4000ms default)
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  pumheight = 10,                          -- pop up menu height
  showtabline = 2,                         -- always show tabs
  --list = false,
  --fillchars = "stl:\ ,stlnc:\ ,fold:\ "
  --listchars = "tab:→\ ,trail:•"
}
-- stylua: ignore end

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- TODO: can we do these with :append?
vim.cmd([[
  set expandtab
  set whichwrap+=<,>,[,],h,l
  set iskeyword+=-
  set formatoptions-=cro
]])
