return {
	"jiangxue-analysis/nvim.comment-hide",
	name = "comment-hide",
	lazy = false,
	config = function()
		require("comment-hide").setup({
			gitignore = true, -- Automatically add .annotations/ to .gitignore.
		})
		vim.keymap.set("n", "<leader>vs", "<cmd>CommentHideSave<CR>", { desc = "Comment: Save (strip comments)" })
		vim.keymap.set("n", "<leader>vr", "<cmd>CommentHideRestore<CR>", { desc = "Comment: Restore from backup" })
	end,
}
