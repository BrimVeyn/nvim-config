return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {}, },
		{ "ray-x/lsp_signature.nvim",
			event = "VeryLazy",
			opts = {
				floating_window = true,
				toggle_key = '<M-p>',
				doc_lines = 0,
				hint_enable = true,
				hint_prefix = '💡',
			},
			config = function(_, opts) require("lsp_signature").setup(opts) end }
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local mappings = require("core.mappings")

		vim.api.nvim_create_autocmd("LspAttach",  {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev) mappings.lspconfig(ev) end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
		})

		local uname = vim.loop.os_uname()

		vim.g.zig_fmt_parse_errors = 0
		vim.g.zig_fmt_autosave = 0

		if uname.machine == "aarch64" then
			lspconfig["clangd"].setup({
				cmd = { "/home/bvan-pae/Downloads/clang+llvm-19.1.0-aarch64-linux-gnu/bin/clangd" },
				capabilities = capabilities,
			})
			lspconfig["zls"].setup({
				cmd = { "/home/bvan-pae/Downloads/zls/zls" },
				capabilities = capabilities,
			})
		else
			lspconfig["zls"].setup({
				cmd = { "/home/brimveyn/apps/zls" },
				capabilities = capabilities,
			})
		end

	end,
}
