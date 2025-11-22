local vimKeymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Git signs
opts.desc = "View diff hunk"
vimKeymap("n", "<localleader>h", function() vim.cmd("Gitsigns preview_hunk_inline") end, opts)

opts.desc = "Toggle line blame"
vimKeymap("n", "<localleader>b", function() vim.cmd("Gitsigns toggle_current_line_blame") end, opts)

opts.desc = "Toggle deleted"
vimKeymap("n", "<localleader>d", function()
	vim.cmd("Gitsigns toggle_deleted")
	vim.cmd("Gitsigns toggle_linehl")
end, opts)

-- DiffView
opts.desc = "Open diff view for the current project"
vimKeymap("n", "<leader>dv", function() vim.cmd("DiffviewOpen") end, { desc = opts.desc })

opts.desc = "Close diff view"
vimKeymap("n", "<leader>dc", function() vim.cmd("DiffviewClose") end, { desc = opts.desc })
