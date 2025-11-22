return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			{
				"j-hui/fidget.nvim",
				opts = {}
			},
		},
		config = function()
			require("mason").setup()
		end,
	},
}
