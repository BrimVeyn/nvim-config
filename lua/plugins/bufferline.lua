local function update_hl()
	local utils = require("core.utils")

	vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = utils.get_mode_hl_color(1) })
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = utils.get_mode_hl_color(1) })
end

local function create_autocmd()
	local augroup = vim.api.nvim_create_augroup("Namicator", {})

	vim.api.nvim_create_autocmd({ "BufEnter", "ModeChanged", "CmdLineEnter" }, {
		callback = update_hl,
		group = augroup,
	})
end

return {
	"BrimVeyn/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons", },
	config = function()
		create_autocmd()

		require('bufferline').setup({
			options = {
				themable = true,
				separator_style = "slope",

			},
			highlights = {
				buffer_selected = {
					bold = true,
					italic = false,
				},
			}
		})
	end,
}
