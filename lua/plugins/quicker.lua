return {
	'stevearc/quicker.nvim',
	event = "FileType qf",
	---@module "quicker"
	opts = {},
	config = function()
		require('quicker').setup()
	end,
}
