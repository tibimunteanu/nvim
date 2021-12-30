local status_ok, cosmic_ui = pcall(require, "cosmic-ui")
if not status_ok then
	vim.notify("Cosmic-ui not found!")
	return
end

cosmic_ui.setup({
	-- default border to use
	-- 'single', 'double', 'rounded', 'solid', 'shadow'
	border = "rounded",

	rename = {
		prompt = "",
		-- nui popup options
		popup_opts = {
			position = {
				row = 1,
				col = 0,
			},
			size = {
				width = 35,
				height = 2,
			},
			relative = "cursor",
			border = {
				highlight = "FloatBorder",
				style = _G.CosmicUI_user_opts.border,
				text = {
					top = " Rename ",
					top_align = "left",
				},
				padding = { 0, 1 },
			},
			win_options = {
				winhighlight = "Normal:Normal",
			},
		},
	},

	code_actions = {

		-- nui popup options
		popup_opts = {
			position = {
				row = 1,
				col = 0,
			},
			relative = "cursor",
			border = {
				highlight = "FloatBorder",
				style = _G.CosmicUI_user_opts.border,
				text = {
					top = " Code Actions ",
					top_align = "left",
				},
				padding = { 0, 1 },
			},
			win_options = {
				winhighlight = "Normal:Normal",
			},
		},
	},
})
