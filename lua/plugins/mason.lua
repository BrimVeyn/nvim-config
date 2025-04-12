return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup()

		local mason_lspconfig = require("mason-lspconfig")
		local uname = vim.loop.os_uname()
		local servers

		if uname.machine == "aarch64" then
			servers = { "lua_ls", "bashls" }
		else
			servers = {
				"clangd",
				"zls",
				"lua_ls",
				"ts_ls",
				"bashls",
				"html",
				"tailwindcss",
				"cssls",
				"jsonls",
				"bashls",
				"dockerls",
				"yamlls",
			}
		end

		mason_lspconfig.setup({
			automatic_installation = true,
			ensure_installed = servers
		})
	end,
}
