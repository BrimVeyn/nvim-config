return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup()
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
					javascript = { "prettier", stop_after_first = true },
					typescript = { "prettier", stop_after_first = true },
					typescriptreact = { "prettier", stop_after_first = true },
					javascriptreact = { "prettier", stop_after_first = true },
					json = { "prettier", stop_after_first = true },
					graphql = { "prettier", stop_after_first = true },
					prisma = { lsp_format = "never" },
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
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require('nvim-ts-autotag').setup({
				opts = {
					enable_close = true,     -- Auto close tags
					enable_rename = true,    -- Auto rename pairs of tags
					enable_close_on_slash = false -- Auto close on trailing </
				},
			})
		end,
	}
}
