return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
		"williamboman/mason-lspconfig.nvim",
		"artemave/workspace-diagnostics.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim",                   opts = {}, },
		{
			"ray-x/lsp_signature.nvim",
			event = "VeryLazy",
			opts = {
				floating_window = true,
				toggle_key = '<M-p>',
				doc_lines = 0,
				hint_enable = true,
				hint_prefix = '💡',
			},
			config = function(_, opts) require("lsp_signature").setup(opts) end
		}
	},
	config = function()
		local mason_lspconfig = require("mason-lspconfig")
		local mappings = require("core.mappings")

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				mappings.lspconfig(ev)
			end,
		})

		local capabilities = require('blink.cmp').get_lsp_capabilities()

		-- Setup mason-lspconfig
		local uname = vim.loop.os_uname()
		local servers

		if uname.machine == "aarch64" then
			servers = { "lua_ls", "bashls" }
		else
			servers = {
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
				-- "prettier",
				-- "prettierd",
				"eslint",
				-- "eslint_d",
				"prismals",
			}
		end

		mason_lspconfig.setup({
			ensure_installed = servers
		})

		-- Configure servers using vim.lsp.config
		for _, server_name in ipairs(servers) do
			vim.lsp.config(server_name, {
				capabilities = capabilities,
			})
		end
	end,
}
