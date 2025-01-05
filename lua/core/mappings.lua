local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap = true, silent = true }

local M = {}

----- Normal -----
opts.desc = "Find files in project"
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
opts.desc = "Fuzzy find in current buffer"
keymap("n", "<leader>fz", ":Telescope current_buffer_fuzzy_find<CR>", opts)
opts.desc = "Fuzzy find in project"
keymap("n", "<leader>fw", ":Telescope live_grep <CR>", opts)

opts.desc = "Classic save"
keymap("n", "<C-s>", ":w<CR>", opts)
opts.desc = "Allow ; to act like : to avoid using shift"
keymap("n", ";", ":", { noremap = true, desc = opts.desc })
opts.desc = "Clear search highlight"
keymap("n", "<ESC>", ":nohlsearch<CR>", opts)

----- Buffer manip ----
opts.desc = "Delete current buffer"
keymap("n", "<leader>x", ":confirm bd <CR>", opts)
opts.desc = "Go to next tab"
keymap("n", "<Tab>", ":BufferLineCycleNext <CR>", opts)
opts.desc = "Go to prev tab"
keymap("n", "<S-Tab>", ":BufferLineCyclePrev <CR>", opts)


opts.desc = "Move focus left split"
keymap("n", "<C-h>", "<C-w>h", opts)
opts.desc = "Move focus down split"
keymap("n", "<C-j>", "<C-w>j", opts)
opts.desc = "Move focus up split"
keymap("n", "<C-k>", "<C-w>k", opts)
opts.desc = "Move focus right split"
keymap("n", "<C-l>", "<C-w>l", opts)

opts.desc = "Resize up"
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
opts.desc = "Resize down"
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
opts.desc = "Resize left"
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
opts.desc = "Resize right"
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

opts.desc = "Automatically centers when C-d"
keymap("n", "<C-d>", "<C-d>zz", opts)
opts.desc = "Automatically centers when C-u"
keymap("n", "<C-u>", "<C-u>zz", opts)


----- File Navigation -----
opts.desc = "Open Mini Files"
keymap("n", "<leader>e", ":lua MiniFiles.open()<CR>", opts)

--keymap("n", "<leader>n", 

----- Insert -------
opts.desc = "Fast exit insert"
keymap("i", "jk", "<ESC>", opts)

opts.desc = "Move up"
keymap("i", "<C-k>", "<Up>", opts)
opts.desc = "Move down"
keymap("i", "<C-j>", "<Down>", opts)
opts.desc = "Move left"
keymap("i", "<C-h>", "<Left>", opts)
opts.desc = "Move right"
keymap("i", "<C-l>", "<Right>", opts)


function M.lspconfig(ev)
	opts = { buffer = ev.buf }
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
end

function M.cmp_native(cmp)
	return {
		["<Tab>"]	= cmp.mapping.select_next_item(), -- Previous suggestion
		["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Next suggestion
		["<CR>"]	= cmp.mapping.confirm({ select = false }),  -- Confirm
		["<C-e>"]	= cmp.mapping.abort(), -- Close
		["<C-b>"]	= cmp.mapping.scroll_docs(-4), -- Move docs up
		["<C-f>"]	= cmp.mapping.scroll_docs(4), -- Move docs down
	}
end

function M.cmp_cmdline(cmp)
	return {
		vim.keymap.set("c", "<Tab>", cmp.mapping.select_next_item(), {}),
		vim.keymap.set("c", "<S-Tab>", cmp.mapping.select_prev_item(), {})
	}
end


return M
