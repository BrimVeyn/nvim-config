return {
	{
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
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig"
		},
		opts = {},
	},
	{
		'stevearc/conform.nvim',
		opts = {},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					python = { "isort", "black" },
					-- Conform will run the first available formatter
					javascript = { "prettierd", "prettier", stop_after_first = true },
				},
				format_on_save = function()
					return { timeout_ms = 3000, lsp_fallback = true }
				end,
			})
		end
	},
	{
		"j-hui/fidget.nvim",
		opts = {},
	}
}
