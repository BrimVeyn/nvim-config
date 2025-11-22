local vimKeymap = vim.keymap.set
local nvimKeymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Editor basics
opts.desc = "Classic save"
vimKeymap("n", "<C-s>", function() vim.cmd("write") end, opts)

opts.desc = "Clear search highlight"
vimKeymap("n", "<ESC>", function() vim.cmd("nohlsearch") end, opts)

-- Scrolling and centering
opts.desc = "Automatically centers when C-d"
nvimKeymap("n", "<C-d>", "<C-d>zz", opts)

opts.desc = "Automatically centers when C-u"
nvimKeymap("n", "<C-u>", "<C-u>zz", opts)

opts.desc = "Cursor follows downscoll"
vim.keymap.set("n", "<C-e>", "<C-e>j", opts)

opts.desc = "Cursor follows upscoll"
vim.keymap.set("n", "<C-y>", "<C-y>k", opts)

opts.desc = "Center when searching"
nvimKeymap("n", "n", "nzzzv", opts)
nvimKeymap("n", "N", "Nzzzv", opts)

-- Search and replace
opts.desc = "Select word (\\v<..>)"
vimKeymap("n", "<leader>rs", "/\\v<><Left>", { desc = opts.desc })

nvimKeymap("n", "<leader>rw",
	[[:let @/='\<'.expand('<cword>').'\>'<CR>:%s/<C-r>///g<Left><Left>]],
	{ desc = "Rename word under cursor" })

-- Comments
opts.desc = "Toggle comment"
nvimKeymap("n", "<leader>/", "gcc", { desc = opts.desc })

opts.desc = "Toggle comment"
nvimKeymap("v", "<leader>/", "gc", { desc = opts.desc })

-- Insert mode navigation
opts.desc = "Move up"
nvimKeymap("i", "<C-k>", "<Up>", opts)

opts.desc = "Move down"
nvimKeymap("i", "<C-j>", "<Down>", opts)

opts.desc = "Move left"
nvimKeymap("i", "<C-h>", "<Left>", opts)

opts.desc = "Move right"
nvimKeymap("i", "<C-l>", "<Right>", opts)

-- Visual mode
opts.desc = "Move selection one line down"
nvimKeymap("v", "J", ":m '>+1<CR>gv=gv", opts)

opts.desc = "Move selection one line up"
nvimKeymap("v", "K", ":m '<-2<CR>gv=gv", opts)

opts.desc = "Indentation plus"
nvimKeymap("v", ">", ">gv", opts)

opts.desc = "Indentation minus"
nvimKeymap("v", "<", "<gv", opts)

opts.desc = "Keep last yanked when pasting"
nvimKeymap("v", "p", '"_dP', opts)

-- Tab stop switcher
local function switchTabStop()
	if vim.bo.tabstop == 4 then
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
		vim.bo.softtabstop = 2
	else
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.softtabstop = 4
	end
end

vimKeymap("n", "<leader>ts", switchTabStop, { desc = "Switch tab stop" })

-- Open in external editor
vimKeymap("n", "<leader>cu", function() require("core.utils").open_in_cursor() end,
	{ desc = "Open in Cursor at current line" })
