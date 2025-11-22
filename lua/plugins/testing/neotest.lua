return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"mfussenegger/nvim-dap",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"antoinemadec/FixCursorHold.nvim",
		"lawrence-laz/neotest-zig",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				-- Registration
				require("neotest-zig")({
					dap = {
						adapter = "lldb",
					},
				}),
			}
		})
	end
}
