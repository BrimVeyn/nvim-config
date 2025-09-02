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
		local clients = vim.lsp.get_clients({ bufnr = 0 })
		for _, client in ipairs(clients) do
			if client.name == "typescript-tools" then
				vim.cmd("TSToolsAddMissingImports")
				break
			end
		end
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesActionRename",
	callback = function(event)
		Snacks.rename.on_rename_file(event.data.from, event.data.to)
	end,
})
