return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim', 'lukahartwig/pnpm.nvim',
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			}
		},

		config = function()
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")

			require('telescope').setup {
				defaults = {
					preview = {
						filesize_limit = 0.1,
					},
					file_ignore_patterns = {
						"%.git/",  -- Ignore .git folder
						"node_modules/", -- Ignore node_modules
						"%.lock",  -- Ignore lock files
						"__pycache__/", -- Ignore Python cache
						"%.o",     -- Ignore object files
						"%.so",    -- Ignore shared objects
					},
					mappings = {
						i = {
							["<C-e>"] = function(prompt_bufnr)
								local entry = action_state.get_selected_entry()
								actions.close(prompt_bufnr)

								if entry and entry.path then
									MiniFiles.open(entry.path, false)
								end
							end
						},
						n = {
							["d"] = require('telescope.actions').delete_buffer,
							["<C-e>"] = function(prompt_bufnr)
								local entry = action_state.get_selected_entry()
								actions.close(prompt_bufnr)

								if entry and entry.path then
									MiniFiles.open(entry.path, false)
								end
							end
						}
					}
				},
				extensions = {
					fzf = {
						fuzzy = true,             -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
				}
			}
			-- To get fzf loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require('telescope').load_extension('fzf')
			require('telescope').load_extension('pnpm')

			local themes = require('telescope.themes')
			local opts = { noremap = true, silent = true }

			vim.keymap.set('n', '<leader>fpw', function()
				require('telescope').extensions.pnpm.workspace(themes.get_ivy({
					initial_mode = "normal",
				}))
			end, { noremap = true, silent = true })

			opts.desc = "Fuzzy find files in project"
			vim.keymap.set("n", "<leader>ff", function()
				require('telescope.builtin').find_files()
			end, opts)

			opts.desc = "Fuzzy find in project"
			vim.keymap.set("n", "<leader>fw", function() vim.cmd("Telescope live_grep") end, opts)

			opts.desc = "Fuzzy find in current buffer"
			vim.keymap.set("n", "<leader>fz", function() vim.cmd("Telescope current_buffer_fuzzy_find") end, opts)

			opts.desc = "Find lsp references"
			vim.keymap.set("n", "<leader>fr", function() vim.cmd("Telescope lsp_references") end, opts)

			opts.desc = "Fuzzy find TODOs"
			vim.keymap.set("n", "<leader>ft", function() vim.cmd("TodoTelescope") end, opts)

			opts.desc = "Fuzzy find document symbols (LSP)"
			vim.keymap.set("n", "<leader>fd", function() vim.cmd("Telescope lsp_document_symbols") end, opts)

			opts.desc = "Fuzzy find buffers"
			vim.keymap.set("n", "<leader>fb", function()
				require('telescope.builtin').buffers(themes.get_ivy({
					initial_mode = "normal",
					sort_mru = true,
				}))
			end, opts)
		end,
	},
}
