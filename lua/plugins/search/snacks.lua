return {
	'folke/snacks.nvim',
	opts = {
		input = { enabled = true },
		rename = { enabled = true },
		terminal = { enabled = true },
		gh = { enabled = true },
		image = {
			enabled = true,
			doc = {
				enabled = false,
			},
			formats = {
				"png",
				"svg",
				"jpg",
				"jpeg",
				"gif",
				"bmp",
				"webp",
				"tiff",
				"heic",
				"avif",
				"mp4",
				"mov",
				"avi",
				"mkv",
				"webm",
				"pdf",
				"icns",
			},
		},
		picker = {
			win = {
				input = {
					keys = {
						["<c-e>"] = { "openInExplorer", mode = { "n", "i" } },
						["<c-j>"] = { "history_forward", mode = { "i" } },
						["<c-k>"] = { "history_back", mode = { "i" } },
						["<c-d>"] = { "preview_scroll_down", mode = { "n" } },
						["<c-u>"] = { "preview_scroll_up", mode = { "n" } },
					}
				}
			},
			actions = {
				openInExplorer = function(picker)
					local selected = picker:current()
					if selected and selected.file then
						require('mini.files').open(selected.file)
						picker:close()
					end
				end,
			}
		}
	},
	keys = {
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers({
					win = {
						input = {
							keys = {
								["dd"] = { "bufdelete", mode = { "n" } }
							}
						}
					}
				})
			end,
			desc = "Find buffers"
		},
		{ "<leader>ff",     function() Snacks.picker.files() end,                     desc = "Find files" },
		{ "<leader>fw",     function() Snacks.picker.grep() end,                      desc = "Find any (live grep)" },
		{ "<localleader>f", function() Snacks.picker.grep_word() end,                 desc = "Find word under cursor (live grep)" },
		{ "<leader>fr",     function() Snacks.picker.lsp_references() end,            desc = "Find lsp references" },
		{ "<leader>fz",     function() Snacks.picker.grep_buffers() end,              desc = "Find in active buffers (live grep)" },
		{ "<leader>fh",     function() Snacks.picker.help() end,                      desc = "Find help pages" },
		{ "<leader>fp",     function() Snacks.picker.picker_layouts() end,            desc = "Find help pages" },
		{ "<leader>fs",     function() vim.cmd("AutoSession search") end,             desc = "Find sessions (browse)" },
		{ "<leader>fS",     function() vim.cmd("AutoSession deletePicker") end,       desc = "Find sessions (delete)" },
		{ "<leader>gi",     function() Snacks.picker.gh_issue() end,                  desc = "GitHub Issues (open)" },
		{ "<leader>gI",     function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
		{ "<leader>gp",     function() Snacks.picker.gh_pr() end,                     desc = "GitHub Pull Requests (open)" },
		{ "<leader>gP",     function() Snacks.picker.gh_pr({ state = "all" }) end,    desc = "GitHub Pull Requests (all)" },
	}
}
