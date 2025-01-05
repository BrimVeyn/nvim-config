return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPre", "BufNewFile", "ModeChanged" },
	config = function()
		require("ibl").setup({
			indent = { char = "┆" },
			scope = {
				show_start = false,
				priority = 500,
			},
		})
	end
}
