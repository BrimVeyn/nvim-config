vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	callback = function()
		if vim.bo.filetype ~= "minifiles" then
			vim.wo.cursorline = true
			vim.wo.cursorcolumn = true
		end
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	callback = function()
		vim.wo.cursorline = false
		vim.wo.cursorcolumn = false
	end,
})


vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function()
		if vim.bo.filetype == "typescriptreact" or vim.bo.filetype == "typescript" then
			vim.cmd("TSToolsAddMissingImports");
		end
	end,
})
