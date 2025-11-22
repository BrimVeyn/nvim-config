return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim', 'lukahartwig/pnpm.nvim',
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			{
				"nvim-telescope/telescope-frecency.nvim",
				-- install any compatible version of 0.9.x
				version = "^0.9.0",
			},
		},

		config = function()
			local git_root_cache = { git_root = "", cwd = vim.fn.getcwd() }

			require('telescope').setup {
				defaults = {

					path_display = function(opts, path)
						_ = opts
						local tail = require("telescope.utils").path_tail(path)
						local current_cwd = vim.fn.getcwd()

						-- Retrigger git_root resolve on directory change
						if git_root_cache.cwd ~= current_cwd then
							git_root_cache = { git_root = "", cwd = current_cwd }
						end

						if git_root_cache.git_root == "" then
							local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
							git_root_cache.git_root = handle and handle:read("*a"):gsub("%s+", "") or ""
							---@diagnostic disable-next-line: need-check-nil
							handle:close()
						end

						local git_root = git_root_cache.git_root
						if git_root ~= "" and path:find(git_root, 1, true) then
							path = path:gsub("^" .. vim.pesc(git_root), "~")
						end

						-- Remove the filename (last component after the last /)
						path = path:gsub("/[^/]*$", "")

						-- Truncate path if longer than 80 characters
						local function truncate_path(p, max_len)
							if #p <= max_len then return p end
							local parts = {}
							for part in p:gmatch("[^/]+/?") do
								table.insert(parts, part)
							end
							while #parts > 1 and #table.concat(parts, "") > max_len do
								table.remove(parts, 1)
							end
							return table.concat(parts, "")
						end
						path = truncate_path(path, 60)

						return string.format("%s [%s]", tail, path)
					end,
					-- path_display = function(opts, path)
					-- 	_ = opts
					-- 	local tail = require("telescope.utils").path_tail(path)
					-- 	return string.format("%s (%s)", tail, path)
					-- end,
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
							["<C-k>"] = require('telescope.actions').cycle_history_next,
							["<C-j>"] = require('telescope.actions').cycle_history_prev,
						},
					}
				},
				extensions = {
					fzf = {
						fuzzy = true,             -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
					frecency = {
						matcher = "fuzzy",
						show_filter_column = false,
						enable_prompt_mappings = true,
					}
				}
			}
			require('telescope').load_extension('fzf')
			require('telescope').load_extension('pnpm')
			require("telescope").load_extension "frecency"

			local themes = require('telescope.themes')
			local opts = { noremap = true, silent = true }

			vim.keymap.set('n', '<leader>fpw', function()
				require('telescope').extensions.pnpm.workspace(themes.get_ivy({
					initial_mode = "normal",
				}))
			end, { noremap = true, silent = true })

			opts.desc = "Fuzzy find document symbols (LSP)"
			vim.keymap.set("n", "<leader>fd", function() vim.cmd("Telescope lsp_document_symbols") end, opts)

			opts.desc = "Fuzzy find keymaps"
			vim.keymap.set("n", "<leader>fk", function() vim.cmd("Telescope keymaps") end, opts)
		end,
	},
}
