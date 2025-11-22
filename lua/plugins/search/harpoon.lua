return {
	{
		'ThePrimeagen/harpoon',
		branch = 'harpoon2',
		opts = {
			menu = {
				width = vim.api.nvim_win_get_width(0) - 4,
			},
			settings = {
				save_on_toggle = true,
			},
		},
		-- stylua: ignore
		keys = {
			{
				'<leader>fl',
				function()
					local harpoon = require('harpoon')
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = 'List locations'
			},
			{ '<leader>al', function() require('harpoon'):list():add() end,    desc = 'Add Location' },
			{ '<leader>rl', function() require('harpoon'):list():remove() end, desc = 'Remove Location' },
			{ '<C-n>',      function() require('harpoon'):list():next() end,   desc = 'Next Location' },
			{ '<C-p>',      function() require('harpoon'):list():prev() end,   desc = 'Previous Location' },
		},
	},
}
