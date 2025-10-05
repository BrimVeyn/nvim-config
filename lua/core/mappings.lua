local nvimKeymap = vim.api.nvim_set_keymap
local vimKeymap  = vim.keymap.set

local opts       = { noremap = true, silent = true }

local utils      = require("core.utils")
local bl         = require("bufferline")

opts.desc        = "Pick a buffer to move current buffer next to"
vimKeymap("n", "<leader>bmp", function() utils.bufferLinePickMove() end, opts)

opts.desc = "Pick many buffers to close (stop with <Escape> or `/`)"
vimKeymap("n", "<leader>bcp", function() utils.bufferLineCloseManyPick() end, opts)
----------------------- Normal ----------------------
---

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

opts.desc = "Open terminal vertical"
vimKeymap("n", "<leader>cv", function() vim.cmd("ToggleTerm direction=vertical size=100") end, opts);
opts.desc = "Open terminal horizontal"
vimKeymap("n", "<leader>ch", function() vim.cmd("ToggleTerm direction=horizontal size=20") end, opts);
opts.desc = "Open terminal float"
vimKeymap("n", "<leader>cf", function() vim.cmd("ToggleTerm direction=float") end, opts);

vimKeymap('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
vimKeymap('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
vimKeymap('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
vimKeymap('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)


opts.desc = "Classic save"
vimKeymap("n", "<C-s>", function() vim.cmd("w") end, opts)
opts.desc = "Clear search highlight"
vimKeymap("n", "<ESC>", function() vim.cmd("nohlsearch") end, opts)

----- Buffer manip ----
opts.desc = "Open new buffer"
vimKeymap("n", "<leader>bn", function() vim.cmd("tabnew") end, opts)
opts.desc = "Pick bufferline tabs"
vimKeymap("n", "<leader>bp", function() bl.pick() end, opts)

----- Close buffers -----
opts.desc = "Close all buffers to the left"
vimKeymap("n", "<leader>bcl", function() vim.cmd("BufferLineCloseLeft") end, opts)
opts.desc = "Close all buffers to the right"
vimKeymap("n", "<leader>bcr", function() vim.cmd("BufferLineCloseRight") end, opts)

opts.desc = "Close all other buffers"
vimKeymap("n", "<leader>bX", function() bl.close_others() end, opts)

opts.desc = "Close current buffer"
vimKeymap("n", "<localleader>w", function() utils.custom_bdelete() end, opts)

opts.desc = "View diff hunk"
vimKeymap("n", "<localleader>h", function() vim.cmd("Gitsigns preview_hunk_inline") end, opts)
opts.desc = "Toggle line blame"
vimKeymap("n", "<localleader>b", function() vim.cmd("Gitsigns toggle_current_line_blame") end, opts)

opts.desc = "Toggle deleted"
vimKeymap("n", "<localleader>d", function()
	vim.cmd("Gitsigns toggle_deleted")
	vim.cmd("Gitsigns toggle_linehl")
end, opts)

opts.desc = "Move current buffer to the right"
vimKeymap("n", "<leader>bmr", function() vim.cmd("BufferLineMoveNext") end, opts)
opts.desc = "Move current buffer to the left"
vimKeymap("n", "<leader>bml", function() vim.cmd("BufferLineMovePrev") end, opts)


vimKeymap("n", "<Tab>", function() bl.cycle(1) end, opts)
opts.desc = "Go to previous buffer"
vimKeymap("n", "<S-Tab>", function() bl.cycle(-1) end, opts)

opts.desc = "Select word (\\v<..>)"
vimKeymap("n", "<leader>rs", "/\\v<><Left>", { desc = opts.desc })

opts.desc = "Open current file in mini.files"
vimKeymap("n", "<leader>fe", function()
	local path = vim.api.nvim_buf_get_name(0)
	require("mini.files").open(path)
end, opts)

vimKeymap("n", "<leader>cu", function() require("core.utils").open_in_cursor() end,
	{ desc = "Open in Cursor at current line" })

nvimKeymap("n", "<leader>rw",
	[[:let @/='\<'.expand('<cword>').'\>'<CR>:%s/<C-r>///g<Left><Left>]],
	{ desc = "Rename word under cursor" })

vimKeymap("n", "<leader>ih", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		vim.notify("Inlay hints " .. (vim.lsp.inlay_hint.is_enabled() and "enabled" or "disabled"))
	end,
	{ desc = "Toggle inlay hints" })


-- ######################################################
-- ####################### Splits #######################
-- ######################################################

opts.desc = "Open vertical split"
vim.keymap.set("n", "<leader>sv", function() vim.cmd("vertical split") end, opts)
opts.desc = "Open horizontal split"
vim.keymap.set("n", "<leader>sh", function() vim.cmd("horizontal split") end, opts)
opts.desc = "Close split"
vim.keymap.set("n", "<leader>sx", function() vim.cmd("close") end, opts)
opts.desc = "Make splits equal"
vim.keymap.set("n", "<leader>s=", "<C-w>=", opts)


opts.desc = "Move focus left split"
nvimKeymap("n", "<C-h>", "<C-w>h", opts)
opts.desc = "Move focus down split"
nvimKeymap("n", "<C-j>", "<C-w>j", opts)
opts.desc = "Move focus up split"
nvimKeymap("n", "<C-k>", "<C-w>k", opts)
opts.desc = "Move focus right split"
nvimKeymap("n", "<C-l>", "<C-w>l", opts)

opts.desc = "Resize up"
vimKeymap("n", "<C-Up>", function() vim.cmd("resize -2") end, opts)
opts.desc = "Resize down"
vimKeymap("n", "<C-Down>", function() vim.cmd("resize +2") end, opts)
opts.desc = "Resize left"
vimKeymap("n", "<C-Left>", function() vim.cmd("vertical resize -2") end, opts)
opts.desc = "Resize right"
vimKeymap("n", "<C-Right>", function() vim.cmd("vertical resize +2") end, opts)

-- ######################################################
-- ############### Centering / Searching ################
-- ######################################################

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
-- nvimKeymap("c", "<CR>", "<CR>zz", opts)

----- File Navigation -----
opts.desc = "Open Mini Files"
vimKeymap("n", "<leader>e", function()
	require("mini.files").open()
	vim.wo.cursorline = false
	vim.wo.cursorcolumn = false
end, opts)

----------------------- Insert ----------------------
opts.desc = "Move up"
nvimKeymap("i", "<C-k>", "<Up>", opts)
opts.desc = "Move down"
nvimKeymap("i", "<C-j>", "<Down>", opts)
opts.desc = "Move left"
nvimKeymap("i", "<C-h>", "<Left>", opts)
opts.desc = "Move right"
nvimKeymap("i", "<C-l>", "<Right>", opts)

----------------------- Visual ----------------------
opts.desc = "Move selection one line down"
nvimKeymap("v", "J", ":m '>+1<CR>gv=gv", opts)
opts.desc = "Move selection one line up"
nvimKeymap("v", "K", ":m '<-2<CR>gv=gv", opts)

opts.desc = "Toggle comment"
nvimKeymap("n", "<leader>/", "gcc", { desc = opts.desc })
opts.desc = "Toggle comment"
nvimKeymap("v", "<leader>/", "gc", { desc = opts.desc })

opts.desc = "Indentation plus"
nvimKeymap("v", ">", ">gv", opts)
opts.desc = "Indentation minus"
nvimKeymap("v", "<", "<gv", opts)

opts.desc = "Keep last yanked when pasting"
nvimKeymap("v", "p", '"_dP', opts)

----------------------- DiffView ----------------------
opts.desc = "Open diff view for the current project"
vimKeymap("n", "<leader>dv", function() vim.cmd("DiffviewOpen") end, { desc = opts.desc })
opts.desc = "Close diff view"
vimKeymap("n", "<leader>dc", function() vim.cmd("DiffviewClose") end, { desc = opts.desc })

----------------------- Plugins ----------------------
local M = {}

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

vimKeymap("n", "<leader>ai",
	function()
		if vim.bo.filetype == "typescriptreact" or vim.bo.filetype == "typescript" then
			vim.cmd("TSToolsAddMissingImports");
		end
	end, { desc = "Add missing imports" })

vimKeymap("n", "<leader>oi",
	function()
		if vim.bo.filetype == "typescriptreact" or vim.bo.filetype == "typescript" then
			vim.cmd("TSToolsOrganizeImports");
		end
	end, { desc = "Organize imports" })

vimKeymap("n", "<leader>ru",
	function()
		if vim.bo.filetype == "typescriptreact" or vim.bo.filetype == "typescript" then
			vim.cmd("TSToolsRemoveUnused");
		end
	end, { desc = "Removed unsused imports/variables" })

vimKeymap("n", "<leader>fa",
	function()
		if vim.bo.filetype == "typescriptreact" or vim.bo.filetype == "typescript" then
			vim.cmd("TSToolsFixAll");
			vim.wait(100);
			vim.cmd("EslintFixAll");
		end
	end, { desc = "Fix all auto-fixable problems" })


function M.lspconfig(ev)
	opts = { buffer = ev.buf }
	opts.desc = "LSP goto declaration"
	vimKeymap("n", "gD", vim.lsp.buf.declaration, opts)
	opts.desc = "LSP goto implementation"
	vimKeymap("n", "gi", vim.lsp.buf.implementation, opts)
	opts.desc = "LSP rename word under cursor"
	vimKeymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
end

function M.wkgroups()
	local wk = require("which-key")

	wk.add({
		{ "<leader>e", icon = "📁" },
		{ "<leader>f", group = "Find" },
		{ "<leader>t", group = "Test", icon = "🧪" },
		{ "<leader>s", group = "Splits", icon = "✂️" },
		{ "<leader>b", group = "Buffers", icon = "🪟" },
		{ "<leader>r", group = "Search & Replace", icon = "👀" },
		{ "<leader>x", group = "Diagnostics", icon = "🛠️" },
		{ "<leader>n", group = "SwapNext", icon = "⇄" },
		{ "<leader>p", group = "SwapPrev", icon = "⇄" },
	})
end



return M
