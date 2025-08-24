return {
	{
		'nvimdev/lspsaga.nvim',
		config = function()
			require('lspsaga').setup({
				lightbulb = {
					enable = false,
				},
				hover = {
					max_width = 0.6,
					open_link = 'gx',
					open_browser = '!open',
				},
			})

			vim.keymap.set('n', 'K', function()
				vim.cmd('Lspsaga hover_doc')
			end, { remap = true })
			vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
			vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
			vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
			vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
			vim.keymap.set("n", "<leader>ox", "<cmd>Lspsaga outline<CR>")
		end,
		event = 'LspAttach',
		dependencies = {
			'nvim-treesitter/nvim-treesitter', -- optional
			'nvim-tree/nvim-web-devicons',  -- optional
		}
	},
	{
		"soulsam480/nvim-oxlint",
		lazy = false,
		opts = {}
	},
	{
		"olrtg/nvim-emmet",
		config = function()
			vim.keymap.set({ "n", "v" }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
		end,
	}

}
