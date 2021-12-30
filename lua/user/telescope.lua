local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	vim.notify("Telescope not found!")
	return
end

telescope.load_extension("git_worktree")
telescope.load_extension("fzy_native")

local actions = require("telescope.actions")

-- stylua: ignore start
telescope.setup {
  defaults = {
    prompt_prefix       = " ",
    selection_caret     = " ",
    -- borderchars      = { '─', '│', '─', '│', '┍', '┑', '┙', '┕' },
    color_devicons      = true,
    path_display        = { "smart" },  
    file_sorter         = require('telescope.sorters').get_fzy_sorter,

    file_previewer      = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer      = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer    = require('telescope.previewers').vim_buffer_qflist.new,

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
    find_files = {
      hidden = true
    },
    git_files = {
      find_command = { "git", "ls-files", "-L", "--exclude-standard", "--cached"}
    },
    file_browser = {
      hidden = true
    },
    buffers = {
      mappings = {
        n = {
          ["d"] = actions.delete_buffer,
        },
      },
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
}
-- stylua: ignore end

local M = {}

M.config_files = function()
	require("telescope.builtin").find_files({
		prompt_title = "vim",
		cwd = "~/.config/nvim/",
	})
end

M.colorscheme_files = function()
	require("telescope.builtin").find_files({
		prompt_title = "colorscheme",
		cwd = "~/.local/share/nvim/site/pack/packer/start/darknvim/",
	})
end

M.git_branches = function()
	require("telescope.builtin").git_branches({
		attach_mappings = function(_, map)
			map("i", "<c-d>", actions.git_delete_branch)
			map("n", "<c-d>", actions.git_delete_branch)
			return true
		end,
	})
end

return M
