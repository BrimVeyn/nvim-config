return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@diagnostic disable-next-line: undefined-doc-name
		---@type Flash.Config
		opts = {},
		-- stylua: ignore
		keys = {
			{ "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
			{ "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
			{ "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
			{ "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search", remap = true },
			{
				"<CR>",
				mode = { "n" },
				function()
					--TODO: Restore default behavior in quickfix
					if vim.bo.filetype == 'qf' then
						return
					end

					local Flash = require("flash")

					---@param opts Flash.Format
					local function format(opts)
						-- always show first and second label
						return {
							---@diagnostic disable-next-line: undefined-field
							{ opts.match.label1, "FlashMatch" },
							---@diagnostic disable-next-line: undefined-field
							{ opts.match.label2, "FlashLabel" },
						}
					end

					Flash.jump({
						search = { mode = "search" },
						label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
						pattern = [[\<]],
						action = function(match, state)
							state:hide()
							Flash.jump({
								search = { max_length = 0 },
								highlight = { matches = false },
								label = { format = format },
								matcher = function(win)
									-- limit matches to the current label
									return vim.tbl_filter(function(m)
										return m.label == match.label and m.win == win
									end, state.results)
								end,
								labeler = function(matches)
									for _, m in ipairs(matches) do
										---@diagnostic disable-next-line: undefined-field
										m.label = m.label2 -- use the second label
									end
								end,
							})
						end,
						labeler = function(matches, state)
							local labels = state:labels()
							for m, match in ipairs(matches) do
								---@diagnostic disable-next-line: inject-field
								match.label1 = labels[math.floor((m - 1) / #labels) + 1]
								---@diagnostic disable-next-line: inject-field
								match.label2 = labels[(m - 1) % #labels + 1]
								match.label = match.label1
							end
						end,
					})

					-- Restore original key mappings
				end,
				remap = true,
				desc = "Flash any word"
			},
		},
	}
}
