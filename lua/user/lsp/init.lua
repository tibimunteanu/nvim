local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	vim.notify("Lspconfig not found!")
	return
end

require("user.lsp.lsp-installer")
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")
