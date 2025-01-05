return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {}, },
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

		if uname.machine == "aarch64" then
			lspconfig["clangd"].setup({
				cmd = { "/home/bvan-pae/Downloads/clang+llvm-19.1.0-aarch64-linux-gnu/bin/clangd" },
				capabilities = capabilities,
			})
		end
	end,
}
