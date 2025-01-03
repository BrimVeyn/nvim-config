return {
	"echasnovski/mini.files",
	dependencies = { "nvim-tree/nvim-web-devicons", opts = {} },
	version = false,
	lazy = false,

	config = function()
		require('mini.files').setup()
	end,


}
