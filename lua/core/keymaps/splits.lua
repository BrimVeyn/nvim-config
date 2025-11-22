local vimKeymap = vim.keymap.set
local nvimKeymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Split management
opts.desc = "Open vertical split"
vim.keymap.set("n", "<leader>sv", function() vim.cmd("vertical split") end, opts)

opts.desc = "Open horizontal split"
vim.keymap.set("n", "<leader>sh", function() vim.cmd("horizontal split") end, opts)

opts.desc = "Close split"
vim.keymap.set("n", "<leader>sx", function() vim.cmd("close") end, opts)

opts.desc = "Make splits equal"
vim.keymap.set("n", "<leader>s=", "<C-w>=", opts)

-- Split navigation
opts.desc = "Move focus left split"
nvimKeymap("n", "<C-h>", "<C-w>h", opts)

opts.desc = "Move focus down split"
nvimKeymap("n", "<C-j>", "<C-w>j", opts)

opts.desc = "Move focus up split"
nvimKeymap("n", "<C-k>", "<C-w>k", opts)

opts.desc = "Move focus right split"
nvimKeymap("n", "<C-l>", "<C-w>l", opts)

-- Split resizing
opts.desc = "Resize up"
vimKeymap("n", "<C-Up>", function() vim.cmd("resize -2") end, opts)

opts.desc = "Resize down"
vimKeymap("n", "<C-Down>", function() vim.cmd("resize +2") end, opts)

opts.desc = "Resize left"
vimKeymap("n", "<C-Left>", function() vim.cmd("vertical resize -2") end, opts)

opts.desc = "Resize right"
vimKeymap("n", "<C-Right>", function() vim.cmd("vertical resize +2") end, opts)
