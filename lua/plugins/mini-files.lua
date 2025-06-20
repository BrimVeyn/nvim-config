return {
	"echasnovski/mini.files",
	dependencies = { "nvim-tree/nvim-web-devicons", opts = {} },
	version = false,
	lazy = false,

	config = function()
		require('mini.files').setup({
			windows = {
				preview = true,
				width_preview = 100,
				width_focus = 35,
				max_number = 3,
			},
		})

		vim.api.nvim_create_autocmd("WinEnter", {
			callback = function()
				if vim.bo.filetype == "mini-files" then
					vim.wo.cursorline = false
					vim.wo.cursorcolumn = false
				end
			end,
		})
	end,
}
