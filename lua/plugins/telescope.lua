return {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },

	config = function()
		require('telescope').setup {
			defaults = {
				preview = {
					filesize_limit = 0.1,
				},
				file_ignore_patterns = {
					"%.git/",     -- Ignore .git folder
					"node_modules/", -- Ignore node_modules
					"%.lock",     -- Ignore lock files
					"__pycache__/", -- Ignore Python cache
					"%.o",        -- Ignore object files
					"%.so",       -- Ignore shared objects
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,                    -- false will only do exact matching
					override_generic_sorter = true,  -- override the generic sorter
					override_file_sorter = true,     -- override the file sorter
					case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
				},
			}
		}
		-- To get fzf loaded and working with telescope, you need to call
		-- load_extension, somewhere after setup function:
		require('telescope').load_extension('fzf')
	end,
}

