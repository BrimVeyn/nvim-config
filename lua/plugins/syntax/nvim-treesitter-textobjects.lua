---@diagnostic disable: deprecated
return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			textobjects = {
				swap = {
					enable = true,
					swap_next = {
						["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
						["<leader>np"] = "@property.outer", -- swap object property with next
						["<leader>nf"] = "@function.outer", -- swap function with next
					},
					swap_previous = {
						["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
						["<leader>pp"] = "@property.outer", -- swap object property with prev
						["<leader>pf"] = "@function.outer", -- swap function with previous
					},
				},
			},
		})
	end,
}
