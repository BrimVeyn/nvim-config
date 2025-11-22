local vimKeymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Neotest
opts.desc = "Open Neotest summary window"
vimKeymap("n", "<leader>ts", function() vim.cmd("Neotest summary") end, opts);

opts.desc = "Open Neotest output for a specific test"
vimKeymap("n", "<leader>to", function() vim.cmd("Neotest output") end, opts);

opts.desc = "Jump to next test"
vimKeymap("n", "<leader>tn", function() vim.cmd("Neotest jump next") end, opts);

opts.desc = "Jump to prev test"
vimKeymap("n", "<leader>tn", function() vim.cmd("Neotest jump prev") end, opts);

opts.desc = "Run all tests in current file"
vimKeymap("n", "<leader>trf", function() require("neotest").run.run(vim.fn.expand("%")) end, opts);

opts.desc = "Run closest test"
vimKeymap("n", "<leader>trt", function() vim.cmd("Neotest run") end, opts);
