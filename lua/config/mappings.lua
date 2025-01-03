local keymap = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

----- Normal -----
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fz", ":Telescope current_buffer_fuzzy_find<CR>", opts)
keymap("n", "<leader>fw", ":Telescope live_grep <CR>", opts)

keymap("n", "<C-s>", ":w<CR>", opts)
keymap("n", ";", ":", { noremap = true })

----- Buffer manip ----
keymap("n", "<leader>x", ":bdelete <CR>", opts)
keymap("n", "<Tab>", ":BufferLineCycleNext <CR>", opts)


keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<leader>e", ":lua MiniFiles.open()<CR>", opts)

--keymap("n", "<leader>n", 

----- Insert -------
keymap("i", "jk", "<ESC>", opts)

keymap("i", "<C-k>", "<Up>", opts)
keymap("i", "<C-j>", "<Down>", opts)
keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-l>", "<Right>", opts)

