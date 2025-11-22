local vimKeymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local utils = require("core.utils")
local bl = require("bufferline")

-- Buffer manipulation
opts.desc = "Pick a buffer to move current buffer next to"
vimKeymap("n", "<leader>bmp", function() utils.bufferLinePickMove() end, opts)

opts.desc = "Pick many buffers to close (stop with <Escape> or `/`)"
vimKeymap("n", "<leader>bcp", function() utils.bufferLineCloseManyPick() end, opts)

opts.desc = "Open new buffer"
vimKeymap("n", "<leader>bn", function() vim.cmd("tabnew") end, opts)

opts.desc = "Pick bufferline tabs"
vimKeymap("n", "<leader>bp", function() bl.pick() end, opts)

-- Close buffers
opts.desc = "Close all buffers to the left"
vimKeymap("n", "<leader>bcl", function() vim.cmd("BufferLineCloseLeft") end, opts)

opts.desc = "Close all buffers to the right"
vimKeymap("n", "<leader>bcr", function() vim.cmd("BufferLineCloseRight") end, opts)

opts.desc = "Close all other buffers"
vimKeymap("n", "<leader>bX", function() bl.close_others() end, opts)

opts.desc = "Close current buffer"
vimKeymap("n", "<localleader>w", function() utils.custom_bdelete() end, opts)

-- Move buffers
opts.desc = "Move current buffer to the right"
vimKeymap("n", "<leader>bmr", function() vim.cmd("BufferLineMoveNext") end, opts)

opts.desc = "Move current buffer to the left"
vimKeymap("n", "<leader>bml", function() vim.cmd("BufferLineMovePrev") end, opts)

-- Buffer navigation
vimKeymap("n", "<Tab>", function() bl.cycle(1) end, opts)

opts.desc = "Go to previous buffer"
vimKeymap("n", "<S-Tab>", function() bl.cycle(-1) end, opts)
