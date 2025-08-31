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
					{ "<leader>fz",     function() Snacks.picker.grep_buffers() end,   desc = "Find in active buffers (live grep)" },
					{ "<leader>fh",     function() Snacks.picker.help() end,           desc = "Find help pages" },
					{ "<leader>fp",     function() Snacks.picker.picker_layouts() end, desc = "Find help pages" },
					{ "<leader>fs",     function() vim.cmd("Autosession search") end,  desc = "Find sessions" },
					{ "<leader>fS",     function() vim.cmd("Autosession delete") end,  desc = "Find sessions" },
					-- { "<leader>fe",     function() Snacks.picker.explorer() end,      desc = "Find sessions" },
				}
			},
		},
		---@diagnostic disable-next-line: undefined-doc-name
		---@type opencode.Opts
		opts = {
			-- Your configuration, if any — see lua/opencode/config.lua
		},
		keys = {
			-- Recommended keymaps
			{ '<leader>oA', function() require('opencode').ask() end,                                     desc = 'Ask opencode', },
			{ '<leader>oa', function() require('opencode').ask('@cursor: ') end,                          desc = 'Ask opencode about this',      mode = 'n', },
			{ '<leader>oa', function() require('opencode').ask('@selection: ') end,                       desc = 'Ask opencode about selection', mode = 'v', },
			{ '<leader>ot', function() require('opencode').toggle() end,                                  desc = 'Toggle embedded opencode', },
			{ '<leader>on', function() require('opencode').command('session_new') end,                    desc = 'New session', },
			{ '<leader>oy', function() require('opencode').command('messages_copy') end,                  desc = 'Copy last message', },
			{ '<S-C-u>',    function() require('opencode').command('messages_half_page_up') end,          desc = 'Scroll messages up', },
			{ '<S-C-d>',    function() require('opencode').command('messages_half_page_down') end,        desc = 'Scroll messages down', },
			{ '<leader>op', function() require('opencode').select_prompt() end,                           desc = 'Select prompt',                mode = { 'n', 'v', }, },
			-- Example: keymap for custom prompt
			{ '<leader>oe', function() require('opencode').prompt("Explain @cursor and its context") end, desc = "Explain code near cursor", },
		},
	},
	-- {
	-- 	"copilotlsp-nvim/copilot-lsp",
	-- 	dependencies = {
	-- 		"github/copilot.vim"
	-- 	},
	-- 	init = function()
	-- 		vim.g.copilot_nes_debounce = 100
	-- 		vim.lsp.enable("copilot_ls")
	-- 		vim.keymap.set("n", "<C-w>", function()
	-- 			local bufnr = vim.api.nvim_get_current_buf()
	-- 			local state = vim.b[bufnr].nes_state
	-- 			if state then
	-- 				-- Try to jump to the start of the suggestion edit.
	-- 				-- If already at the start, then apply the pending suggestion and jump to the end of the edit.
	-- 				local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
	-- 						or (
	-- 							require("copilot-lsp.nes").apply_pending_nes()
	-- 							and require("copilot-lsp.nes").walk_cursor_end_edit()
	-- 						)
	-- 				return nil
	-- 			else
	-- 				-- Resolving the terminal's inability to distinguish between `TAB` and `<C-i>` in normal mode
	-- 				return "<C-i>"
	-- 			end
	-- 		end, { desc = "Accept Copilot NES suggestion", expr = true })
	-- 	end,
	-- 	config = function()
	-- 		require('copilot-lsp').setup({
	-- 			---@diagnostic disable-next-line: missing-fields
	-- 			nes = {
	-- 				distance_threshold = 100,
	-- 				move_count_threshold = 3, -- Clear after 3 cursor movements
	-- 			}
	-- 		})
	-- 	end
	-- },
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
