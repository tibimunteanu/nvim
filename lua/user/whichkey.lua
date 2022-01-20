local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	vim.notify("Which-key not found!")
	return
end

local ns = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local map = function(label, mapping)
	return { mapping, label }
end

-- Map Space as leader
keymap("", "<Space>", "<Nop>", ns)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable mouse
keymap("", "<MiddleMouse>", "<Nop>", ns)
keymap("", "<LeftMouse>", "<Nop>", ns)
keymap("", "<RightMouse>", "<Nop>", ns)
keymap("t", "<MiddleMouse>", "<Nop>", ns)
keymap("t", "<LeftMouse>", "<Nop>", ns)
keymap("t", "<RightMouse>", "<Nop>", ns)

-- Press jk fast to enter normal mode
keymap("i", "jk", "<ESC>", ns)
keymap("t", "jk", "<C-\\><C-n>", ns)

-- stylua: ignore start
local normal = {
  ["<Left>"]  = map("Move to left pane",          "<C-w>h"),
  ["<Down>"]  = map("Move to pane below",         "<C-w>j"),
  ["<Up>"]    = map("Move to pane above",         "<C-w>k"),
  ["<Right>"] = map("Move to right pane",         "<C-w>l"),
  ["<C-l>"]   = map("Next buffer",                "<cmd>BufferLineCycleNext<CR>"),
  ["<C-h>"]   = map("Previous buffer",            "<cmd>BufferLineCyclePrev<CR>"),
  ["<C-j>"]   = map("Scroll down",                "<C-e><C-e><C-e>"),
  ["<C-k>"]   = map("Scroll up",                  "<C-y><C-y><C-y>"),
  ["<C-n>"]   = map("Next qf item",               "<cmd>cnext<CR>"),
  ["<C-p>"]   = map("Prev qf item",               "<cmd>cprev<CR>"),
  ["-"]       = map("Go back",                    "<C-o>"),
  ["_"]       = map("Go forward",                 "<C-i>"),
  H           = map("Go to line start",           "^"),
  L           = map("Go to line end",             "$"),
  Q           = map("Apply macro",                "@q"),
  K           = map("Hover",                      "<cmd>lua vim.lsp.buf.hover()<CR>"),

  g = {
    name      = "LSP",
    d         = map("Go to definition",           "<cmd>lua vim.lsp.buf.definition()<CR>"),
    D         = map("Go to declaration",          "<cmd>lua vim.lsp.buf.declaration()<CR>"),
    i         = map("Go to implementation",       "<cmd>lua vim.lsp.buf.implementation()<CR>"),
    r         = map("Find all references",        "<cmd>lua vim.lsp.buf.references()<CR>"),
    f         = map("Format buffer",              "<cmd>lua vim.lsp.buf.formatting()<CR>"),
    l         = map("Show line diagnostic",       "<cmd>lua vim.diagnostic.open_float()<CR>"),
    ["."]     = map("Code actions",               "<cmd>Telescope lsp_code_actions<CR>"), -- <cmd>lua require('cosmic-ui').code_actions()<CR>") -- lua vim.lsp.buf.code_action()
    s         = map("Document symbol",            "<cmd>lua vim.lsp.buf.document_symbol()<CR>"),
  },

  ["<leader>"] = {
    e         = map("Toggle explorer",            "<cmd>NvimTreeToggle<CR>"),
    r         = map("Refresh explorer",           "<cmd>NvimTreeRefresh<CR>"),
    n         = map("Sync explorer",              "<cmd>NvimTreeFindFile<CR>"),
    s         = map("Swap panes",                 "<C-w>r<cmd>NvimTreeToggle<CR><cmd>NvimTreeToggle<CR><C-w>l"),
    c         = map("Close buffer",               "<cmd>Bdelete<CR>"),
    -- C         = map("Close all but current",      "<cmd>BufferCloseAllButCurrent<CR>"),
    p         = map("Pin buffer",                 "<cmd>lua require('user.bufferline').toggle_pin()<CR>"),
    P         = map("Close all but pinned",       "<cmd>lua require('bufferline').close_all_but_pinned()<CR>"),
    x         = map("Close window",               "<cmd>x<CR>"),
    w         = map("Scratch buffer",             "<cmd>Scratch<CR>"),
    t         = map("Open terminal",              "<cmd>FloatermToggle<<CR>"),

    b = {
      name    = "Manage buffers",
      l       = map("Move to right",              "<cmd>BufferLineMoveNext<CR>"),
      h       = map("Move to left",               "<cmd>BufferLineMovePrev<CR>"),
      c       = map("Close buffer",               "<cmd>Bdelete<CR>"),
      -- C       = map("Close all but current",      "<cmd>BufferCloseAllButCurrent<CR>"),
      -- p       = map("Pin buffer",                 "<cmd>BufferPin<CR>"),
      P       = map("Close all but pinned",       "<cmd>lua require('bufferline').close_all_but_pinned()<CR>"),
    },

    f = {
      name    = "Find",
      v       = map("Config files",               "<cmd>lua require('user.telescope').config_files()<CR>"),
      c       = map("Colorscheme files",          "<cmd>lua require('user.telescope').colorscheme_files()<CR>"),
      o       = map("Buffers",                    "<cmd>lua require('user.telescope').open_buffers()<CR>"),
      f       = map("Git files",                  "<cmd>lua require('user.telescope').project_files()<CR>"),
      i       = map("Grep",                       "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For >') })<CR>"),
      w       = map("Grep current word",          "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })<CR>"),
      g       = map("Live grep",                  "<cmd>Telescope live_grep<CR>"),
      a       = map("All files",                  "<cmd>Telescope find_files<CR>"),
      h       = map("Help tags",                  "<cmd>Telescope help_tags<CR>"),
      e       = map("File browser",               "<cmd>Telescope file_browser<CR>"),
      z       = map("Grep in file",               "<cmd>Telescope current_buffer_fuzzy_find<CR>"),
      d       = map("Document diagnostics",       "<cmd>Telescope diagnostics bufnr=0<CR>"),
      D       = map("Workspace diagnostics",      "<cmd>Telescope diagnostics<CR>"),
      s       = map("Document Symbols",           "<cmd>Telescope lsp_document_symbols<CR>"),
      S       = map("Workspace Symbols",          "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>"),
      t       = map("Colorschemes",               "<cmd>Telescope colorscheme<CR>"),
      m       = map("Man pages",                  "<cmd>Telescope man_pages<CR>"),
      r       = map("Open recent file",           "<cmd>Telescope oldfiles<CR>"),
      R       = map("Registers",                  "<cmd>Telescope registers<CR>"),
      k       = map("Keymaps",                    "<cmd>Telescope keymaps<CR>"),
      [":"]   = map("Commands",                   "<cmd>Telescope commands<CR>"),
    },

    l = {
      name    = "LSP",
      i       = map("Info",                       "<cmd>LspInfo<CR>"),
      I       = map("Installer Info",             "<cmd>LspInstallInfo<CR>"),
      a       = map("Code actions",               "<cmd>lua require('cosmic-ui').code_actions()<CR>"), -- lua vim.lsp.buf.code_action()
      l       = map("CodeLens action",            "<cmd>lua vim.lsp.codelens.run()<CR>"),
      r       = map("Rename",                     "<cmd>lua require('cosmic-ui').rename()<CR>"), -- lua vim.lsp.buf.rename()
      h       = map("Hover",                      "<cmd>lua vim.lsp.buf.hover()<CR>"),
      f       = map("Function signature",         "<cmd>lua vim.lsp.buf.signature_help()<CR>"),
      q       = map("Location list diagnostics",  "<cmd>lua vim.diagnostic.setloclist()<CR>"),
    },

    g = {
      name    = "Git",
      g       = map("Lazygit",                    "<cmd>lua _LAZYGIT_TOGGLE()<CR>"),
      d       = map("Diff",                       "<cmd>Gitsigns diffthis HEAD<CR>"),
      j       = map("Next Hunk",                  "<cmd>lua require('gitsigns').next_hunk()<CR>"),
      k       = map("Prev Hunk",                  "<cmd>lua require('gitsigns').prev_hunk()<CR>"),
      l       = map("Blame",                      "<cmd>lua require('gitsigns').blame_line()<CR>"),
      p       = map("Preview Hunk",               "<cmd>lua require('gitsigns').preview_hunk()<CR>"),
      r       = map("Reset Hunk",                 "<cmd>lua require('gitsigns').reset_hunk()<CR>"),
      R       = map("Reset Buffer",               "<cmd>lua require('gitsigns').reset_buffer()<CR>"),
      s       = map("Stage Hunk",                 "<cmd>lua require('gitsigns').stage_hunk()<CR>"),
      u       = map("Undo Stage Hunk",            "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>"),
      o       = map("Open changed file",          "<cmd>Telescope git_status<CR>"),
      b       = map("Branches",                   "<cmd>Telescope git_branches<CR>"),
      c       = map("Commits",                    "<cmd>Telescope git_commits<CR>"),
      h       = map("Stash",                      "<cmd>Telescope git_stash<CR>"),
      w       = map("Worktrees",                  "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>"),
      n       = map("Create worktree",            "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>"),
    },

    i = {
      name    = "Packer",
      c       = map("Compile",                    "<cmd>PackerCompile<CR>"),
      i       = map("Install",                    "<cmd>PackerInstall<CR>"),
      s       = map("Sync",                       "<cmd>PackerSync<CR>"),
      S       = map("Status",                     "<cmd>PackerStatus<CR>"),
      u       = map("Update",                     "<cmd>PackerUpdate<CR>"),
    },
  }
}

local visual = {
  [">"]       = map("Indent",                     ">gv"),
  ["<"]       = map("Indent back",                "<gv"),
  ["<A-j>"]   = map("Move selection down",        ":m .+1<CR>=="),
  ["<A-k>"]   = map("Move selection up",          ":m .-2<CR>=="),
  p           = map("Paste after cursor",         '"_dP'),
  P           = map("Paste before cursor",        '"_dP'),
  Q           = map("Apply macro",                ":norm @q<CR>"),
  H           = map("To line start",              "^"),
  L           = map("To line end",                "$"),
  [","]       = map("To ,",                       "t,"),
  [";"]       = map("To ;",                       "t;"),
  ["0"]       = map("To )",                       "t)"),
  ["9"]       = map("In (",                       "i("),
  ["["]       = map("In block",                   "iB"),
}

local insert = {
  ["<C-j>"]   = map("Scroll down",                "<ESC><C-e><C-e><C-e>"),
  ["<C-k>"]   = map("Scroll up",                  "<ESC><C-y><C-y><C-y>"),
}

local operatorPending = {
  H           = map("To line start",              "^"),
  L           = map("To line end",                "$"),
  [","]       = map("To ,",                       "t,"),
  [";"]       = map("To ;",                       "t;"),
  ["0"]       = map("To )",                       "t)"),
  ["9"]       = map("In (",                       "i("),
  ["["]       = map("In block",                   "iB"),
}

local terminal = {
  ["<ESC>"]   = map("Exit",                       "<cmd>FloatermToggle<CR>"),
  ["<C-n>"]   = map("New",                        "<cmd>FloatermNew<CR>"),
  ["<C-h>"]   = map("Prev",                       "<cmd>FloatermPrev<CR>"),
  ["<C-l>"]   = map("Next",                       "<cmd>FloatermNext<CR>"),
  -- ["<leader>"] = {
  --   t         = map("Exit",                       "<cmd>FloatermToggle<CR>"),
  --   x         = map("Kill",                       "<cmd>FloatermKill<CR>"),
  -- },
}
-- stylua: ignore end

-- these need expr = true
-- <leader>q = { "empty(filter(getwininfo(), 'v:val.quickfix')) ? ':copen<CR>' : ':cclose<CR>'", "Toggle quickfix" },

which_key.setup({
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		["<space>"] = "SPACE",
		["<CR>"] = "ENTER",
		["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
})

which_key.register(normal, { mode = "n", prefix = "", buffer = nil, silent = true, noremap = true, nowait = true })
which_key.register(visual, { mode = "v", prefix = "", buffer = nil, silent = true, noremap = true, nowait = true })
which_key.register(insert, { mode = "i", prefix = "", buffer = nil, silent = true, noremap = true, nowait = true })
which_key.register(terminal, { mode = "t", prefix = "", buffer = nil, silent = true, noremap = true, nowait = true })
which_key.register(
	operatorPending,
	{ mode = "o", prefix = "", buffer = nil, silent = true, noremap = true, nowait = true }
)
