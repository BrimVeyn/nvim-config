return {
	{

		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"saghen/blink.cmp",
			"williamboman/mason-lspconfig.nvim",
			"artemave/workspace-diagnostics.nvim",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "folke/neodev.nvim",                   opts = {}, },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")
			local mappings = require("core.keymaps")

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					mappings.lspconfig(ev)
				end,
			})

			local capabilities = require('blink.cmp').get_lsp_capabilities()

			-- Servers with new-style lsp/*.lua configs (use native vim.lsp API)
			local native_servers = {
				"clangd",
				"lua_ls",
				"bashls",
				"html",
				"cssls",
				"jsonls",
				"dockerls",
				"yamlls",
				"prismals",
			}

			-- Servers with old-style configs only (use lspconfig.setup())
			-- These don't have lsp/*.lua files in nvim-lspconfig yet
			local legacy_servers = {
				"zls",
				"tailwindcss",
				"eslint",
			}

			local all_servers = vim.list_extend(
				vim.list_extend({}, native_servers),
				legacy_servers
			)

			mason_lspconfig.setup({
				ensure_installed = all_servers
			})

			-- Configure native servers
			for _, server_name in ipairs(native_servers) do
				vim.lsp.config(server_name, {
					capabilities = capabilities,
				})
			end
			vim.lsp.enable(native_servers)

			-- Configure legacy servers via lspconfig
			lspconfig.zls.setup({
				capabilities = capabilities,
			})

			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
			})

			lspconfig.eslint.setup({
				capabilities = capabilities,
				settings = {
					workingDirectories = { { mode = "auto" } },
				},
			})
		end,
	},
}
