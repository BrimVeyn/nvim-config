return {
	"echasnovski/mini.files",
	dependencies = { "nvim-tree/nvim-web-devicons", opts = {} },
	version = false,
	lazy = false,

	config = function()
		require('mini.files').setup({
			windows = {
				preview = true,
				width_preview = 40,
				width_focus = 35,
				max_number = 3,
			},
		})
	end,
}
