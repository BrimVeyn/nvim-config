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
			local mason_lspconfig = require("mason-lspconfig")
			local mappings = require("core.keymaps")

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					mappings.lspconfig(ev)
				end,
			})

			local capabilities = require('blink.cmp').get_lsp_capabilities()

			local servers = {
				"clangd",
				"zls",
				"lua_ls",
				"bashls",
				"html",
				"tailwindcss",
				"cssls",
				"jsonls",
				"bashls",
				"dockerls",
				"yamlls",
				"eslint",
				"prismals",
			}


			mason_lspconfig.setup({
				ensure_installed = servers
			})

			-- Configure servers using vim.lsp.config
			for _, server_name in ipairs(servers) do
				local config = {
					capabilities = capabilities,
				}
				if (server_name == "eslint") then
					vim.lsp.config("eslint", {
						settings = {
							workingDirectories = { { mode = "auto" } },
						},
					})
				else
					vim.lsp.config(server_name, config)
				end
			end
		end,
	},
}
