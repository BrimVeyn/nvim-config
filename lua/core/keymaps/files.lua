local vimKeymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- File navigation
opts.desc = "Open Mini Files"
vimKeymap("n", "<leader>e", function()
	require("mini.files").open()
	vim.wo.cursorline = false
	vim.wo.cursorcolumn = false
end, opts)

opts.desc = "Open current file in mini.files"
vimKeymap("n", "<leader>fe", function()
	local path = vim.api.nvim_buf_get_name(0)
	require("mini.files").open(path)
end, opts)
