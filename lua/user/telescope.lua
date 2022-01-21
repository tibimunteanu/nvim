local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	vim.notify("Telescope not found!")
	return
end

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local themes = require("telescope.themes")
local sorters = require("telescope.sorters")
local previewers = require("telescope.previewers")

telescope.load_extension("git_worktree")
telescope.load_extension("fzy_native")

local M = {}

M.verticalOpts = {
	hidden = true,
	layout_strategy = "vertical",
	layout_config = {
		width = 0.9,
		height = 0.95,
		prompt_position = "bottom",
		preview_cutoff = 60,
		preview_height = 0.7,
		scroll_speed = 3,
	},
}

M.flexOpts = {
	hidden = true,
	layout_strategy = "flex",
	layout_config = {
		flip_columns = 170,
		flip_lines = 100,
		horizontal = {
			width = 0.9,
			height = 0.95,
			prompt_position = "bottom",
			preview_width = 0.6,
			preview_cutoff = 60,
			scroll_speed = 3,
		},
		vertical = {
			width = 0.9,
			height = 0.95,
			prompt_position = "bottom",
      preview_height = 0.7,
			preview_cutoff = 80,
			scroll_speed = 3,
		},
	},
}

M.ivyOpts = themes.get_ivy()
M.cursorOpts = themes.get_cursor()
M.cursorPreviewOpts = themes.get_cursor({
  layout_config = {
    width = 0.7,
    height = 0.2,
    preview_cutoff = 60,
    preview_width = 0.6,
    scroll_speed = 3,
  }
})

-- stylua: ignore start
telescope.setup {
  defaults = {
    prompt_prefix       = " ",
    selection_caret     = " ",
    -- borderchars      = { '─', '│', '─', '│', '┍', '┑', '┙', '┕' },
    color_devicons      = true,
    path_display        = { "smart" },
    file_sorter         = sorters.get_fzy_sorter,

    file_previewer      = previewers.vim_buffer_cat.new,
    grep_previewer      = previewers.vim_buffer_vimgrep.new,
    qflist_previewer    = previewers.vim_buffer_qflist.new,

    mappings = {
      n = {
        ["<ESC>"]       = actions.close,
        ["<CR>"]        = actions.select_default,
        ["<C-x>"]       = actions.select_horizontal,
        ["<C-v>"]       = actions.select_vertical,
        ["<C-t>"]       = actions.select_tab,
        ["<Tab>"]       = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"]     = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"]       = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"]       = actions.send_selected_to_qflist + actions.open_qflist,
        ["j"]           = actions.move_selection_next,
        ["k"]           = actions.move_selection_previous,
        ["<C-k>"]       = actions.preview_scrolling_up,
        ["<C-j>"]       = actions.preview_scrolling_down,
        ["<PageUp>"]    = actions.results_scrolling_up,
        ["<PageDown>"]  = actions.results_scrolling_down,
        ["?"]           = actions.which_key,

        ["gg"]          = actions.move_to_top,
        ["G"]           = actions.move_to_bottom,
      },
      i = {
        ["<ESC>"]       = actions.close,
        ["<CR>"]        = actions.select_default,
        ["<C-x>"]       = actions.select_horizontal,
        ["<C-v>"]       = actions.select_vertical,
        ["<C-t>"]       = actions.select_tab,
        ["<Tab>"]       = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"]     = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"]       = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"]       = actions.send_selected_to_qflist + actions.open_qflist,
        ["<Down>"]      = actions.move_selection_next,
        ["<Up>"]        = actions.move_selection_previous,
        ["<C-k>"]       = actions.preview_scrolling_up,
        ["<C-j>"]       = actions.preview_scrolling_down,
        ["<PageUp>"]    = actions.results_scrolling_up,
        ["<PageDown>"]  = actions.results_scrolling_down,
        ["<C-_>"]       = actions.which_key, -- keys from pressing <C-/>}

        ["<C-n>"]       = actions.cycle_history_next,
        ["<C-p>"]       = actions.cycle_history_prev,
        ["<C-l>"]       = actions.complete_tag,
      },
    },
  },
  pickers = {
    git_files = M.verticalOpts,
    find_files = M.verticalOpts,
    buffers = M.cursorPreviewOpts,
    file_browser = M.verticalOpts,
    git_branches = M.verticalOpts,
    grep_string = M.verticalOpts,
    live_grep = M.verticalOpts,
    diagnostics = M.verticalOpts,
    lsp_document_symbols = M.verticalOpts,
    lsp_dynamic_workspace_symbols = M.verticalOpts,
    colorscheme = M.verticalOpts,
    man_pages = M.verticalOpts,
    oldfiles = M.verticalOpts,
    registers = M.verticalOpts,
    keymaps = M.verticalOpts,
    commands = M.verticalOpts,
    git_status = M.verticalOpts,
    current_buffer_fuzzy_find = M.ivyOpts,
    lsp_code_actions = M.cursorOpts,
    lsp_references = M.cursorPreviewOpts,
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
}
-- stylua: ignore end

M.project_files = function()
	local ok = pcall(builtin.git_files, {
		find_command = { "git", "ls-files", "-L", "--exclude-standard", "--cached" },
	})
	if not ok then
		builtin.find_files({})
	end
end

M.open_buffers = function()
	builtin.buffers({
		attach_mappings = function(_, map)
			map("n", "<c-d>", actions.delete_buffer)
			return true
		end,
	})
end

M.config_files = function()
	builtin.find_files({
		prompt_title = "vim",
		cwd = "~/.config/nvim/",
	})
end

M.colorscheme_files = function()
	builtin.find_files({
		prompt_title = "colorscheme",
		cwd = "~/.local/share/nvim/site/pack/packer/start/darknvim/",
	})
end

M.git_branches = function()
	builtin.git_branches({
		attach_mappings = function(_, map)
			map("i", "<c-d>", actions.git_delete_branch)
			map("n", "<c-d>", actions.git_delete_branch)
			return true
		end,
	})
end

return M
