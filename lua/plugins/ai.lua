return {
	{
		'NickvanDyke/opencode.nvim',
		dependencies = {
			{
				'folke/snacks.nvim',
				dependencies = {
					"folke/todo-comments.nvim",
					dependencies = { "nvim-lua/plenary.nvim" },
					keys = {
					},
					lazy = false,
					config = function()
						require("todo-comments").setup()
					end,
				},
				---@type snacks.Config
				opts = {
					input = { enabled = true },
					rename = { enabled = true },
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
					{
						"<leader>ff",
						function()
							Snacks.picker.files({
								layout = require("snacks.picker.config.layouts").vscode,
							})
						end,
						desc = "Find files"
					},
					{ "<leader>fw",     function() Snacks.picker.grep() end,           desc = "Find any (live grep)" },
					{ "<localleader>f", function() Snacks.picker.grep_word() end,      desc = "Find word under cursor (live grep)" },
					-- NOTE: Fix this typing issue
					-- {
					-- 	"<leader>fd",
					-- 	function()
					-- 		Snacks.picker.lsp_symbols({
					-- 			input = true,
					-- 		})
					-- 	end,
					-- 	desc = "Find document symbols"
					-- },
					{ "<leader>fr",     function() Snacks.picker.lsp_references() end, desc = "Find lsp references" },
					{ "<leader>fz",     function() Snacks.picker.grep_buffers() end,   desc = "Find in active buffers (live grep)" },
					{ "<leader>fh",     function() Snacks.picker.help() end,           desc = "Find help pages" },
					{ "<leader>fp",     function() Snacks.picker.picker_layouts() end, desc = "Find help pages" },
					{ "<leader>fs",     function() vim.cmd("AutoSession search") end,  desc = "Find sessions (browse)" },
					{ "<leader>fS",     function() vim.cmd("AutoSession delete") end,  desc = "Find sessions (delete)" },
					-- { "<leader>fe",     function() Snacks.picker.explorer() end,      desc = "Find sessions" },
				}
			},
		},
		config = function()
			vim.g.opencode_opts = {
				-- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition" on `opencode_opts`.
			}

			-- Required for `vim.g.opencode_opts.auto_reload`.
			vim.o.autoread = true

			-- Recommended/example keymaps.
			vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end,
				{ desc = "Ask about this" })
			vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end, { desc = "Select prompt" })
			vim.keymap.set({ "n", "x" }, "<leader>o+", function() require("opencode").prompt("@this") end,
				{ desc = "Add this" })
			vim.keymap.set("n", "<leader>ot", function() require("opencode").toggle() end, { desc = "Toggle embedded" })
			vim.keymap.set("n", "<leader>oc", function() require("opencode").command() end, { desc = "Select command" })
			vim.keymap.set("n", "<leader>on", function() require("opencode").command("session_new") end,
				{ desc = "New session" })
			vim.keymap.set("n", "<leader>oi", function() require("opencode").command("session_interrupt") end,
				{ desc = "Interrupt session" })
			vim.keymap.set("n", "<leader>oA", function() require("opencode").command("agent_cycle") end,
				{ desc = "Cycle selected agent" })
			vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("messages_half_page_up") end,
				{ desc = "Messages half page up" })
			vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("messages_half_page_down") end,
				{ desc = "Messages half page down" })
		end,
	},
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<C-w>",
					clear_suggestion = "<C-e>",
					accept_word = "<C-]>",
				},
			})
		end,
	},
}
