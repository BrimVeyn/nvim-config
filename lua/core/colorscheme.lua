return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		vim.cmd[[colorscheme tokyonight-night]]
		vim.cmd("set cursorline")
		vim.cmd("set cursorcolumn")
	end,
}
