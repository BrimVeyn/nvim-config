return {
	{
		"echasnovski/mini.files",
		dependencies = { "nvim-tree/nvim-web-devicons", opts = {} },
		version = false,
		lazy = false,

		config = function()
			require('mini.files').setup({
				windows = {
					preview = true,
					width_preview = math.floor(vim.api.nvim_win_get_width(0) * 0.5),
					width_focus = math.floor(vim.api.nvim_win_get_width(0) * 0.2),
					width_nofocus = math.floor(vim.api.nvim_win_get_width(0) * 0.1),
					max_number = 3,
				},
			})

			local map_split = function(buf_id, lhs, direction)
				local rhs = function()
					-- Make new window and set it as target
					local cur_target = MiniFiles.get_explorer_state().target_window
					local new_target = vim.api.nvim_win_call(cur_target, function()
						vim.cmd(direction .. ' split')
						---@diagnostic disable-next-line: redundant-return-value
						return vim.api.nvim_get_current_win()
					end)

					MiniFiles.set_target_window(new_target)
					MiniFiles.go_in()
					MiniFiles.close()
				end

				-- Adding `desc` will result into `show_help` entries
				local desc = 'Split ' .. direction
				vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
			end

			vim.api.nvim_create_autocmd('User', {
				pattern = 'MiniFilesBufferCreate',
				callback = function(args)
					local buf_id = args.data.buf_id
					-- Tweak keys to your liking
					map_split(buf_id, '<C-s>', 'belowright horizontal')
					map_split(buf_id, '<C-v>', 'belowright vertical')
				end,
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
	},
	{
		'echasnovski/mini.align',
		version = '*',
		config = function()
			require('mini.align').setup()
		end
	}
}
