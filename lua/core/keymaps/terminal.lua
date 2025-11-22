local vimKeymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Terminal
opts.desc = "Open terminal vertical"
vimKeymap("n", "<leader>cv", function() vim.cmd("ToggleTerm direction=vertical size=100") end, opts)

opts.desc = "Open terminal horizontal"
vimKeymap("n", "<leader>ch", function() vim.cmd("ToggleTerm direction=horizontal size=20") end, opts)

opts.desc = "Open terminal float"
vimKeymap("n", "<leader>cf", function() vim.cmd("ToggleTerm direction=float") end, opts)

-- Terminal mode navigation
vimKeymap('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
vimKeymap('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
vimKeymap('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
vimKeymap('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
