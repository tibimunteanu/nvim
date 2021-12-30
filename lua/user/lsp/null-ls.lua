local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	vim.notify("Null-ls not found!")
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = false,
	sources = {
		-- ES
		diagnostics.eslint_d,
		code_actions.eslint_d,
		code_actions.gitsigns,
		formatting.prettierd.with({
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
				"css",
				"scss",
				"less",
				"html",
				"json",
				"yaml",
				"markdown",
				"graphql",
			},
			command = "prettierd",
			args = { "$FILENAME" },
			-- prefer_local = "node_modules/.bin",
			-- extra_args = {
			--   -- "--no-semi",
			--   "--single-quote",
			--   "--jsx-single-quote"
			-- },
		}),

		-- LUA
		formatting.stylua,
	},
})
