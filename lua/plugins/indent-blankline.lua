return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPre", "BufNewFile", "ModeChanged" },
	config = function()
		local hooks = require("ibl.hooks")
		local utils = require("core.utils")

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "IblIndent", { fg = utils.get_mode_hl_color(0.4) })
			vim.api.nvim_set_hl(0, "IblScope", { fg = utils.get_mode_hl_color(1) })
		end)

		local config = {
			indent = {
				char = "┆",
			},
			scope = {
				priority = 500,
				show_start = false,
				show_end = false,
			}
		}

		-- Forcing indentBlanLine to refresh since it's refresh func doesn't work
		vim.api.nvim_create_autocmd("ModeChanged", {
			callback = function()
				-- Check if the current buffer is a Telescope picker
				local bufname = vim.api.nvim_buf_get_name(0)
				if bufname:match("") then
					return
				end
				-- Otherwise, execute the setup
				require("ibl").setup(config)
			end,
		})

		require("ibl").setup(config)
	end
}
