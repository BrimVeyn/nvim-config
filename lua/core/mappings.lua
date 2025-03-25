local keymap = vim.api.nvim_set_keymap
local nvimKeymap = vim.api.nvim_set_keymap
local vimKeymap = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap = true, silent = true }


----------------------- Normal ----------------------
opts.desc = "Fuzzy find files in project"
vimKeymap("n", "<leader>ff", function() vim.cmd("Telescope find_files") end, opts)
opts.desc = "Fuzzy find in project"
vimKeymap("n", "<leader>fw", function() vim.cmd("Telescope live_grep") end, opts)
opts.desc = "Fuzzy find in current buffer"
vimKeymap("n", "<leader>fz", function() vim.cmd("Telescope current_buffer_fuzzy_find") end, opts)
opts.desc = "Find lsp references"
vimKeymap("n", "<leader>fr", function() vim.cmd("Telescope lsp_references") end, opts)
opts.desc = "Fuzzy find TODOs"
vimKeymap("n", "<leader>ft", function() vim.cmd("TodoTelescope") end, opts)
opts.desc = "Find buffers"
vimKeymap("n", "<leader>fb", function() vim.cmd("Telescope buffers") end, opts)
opts.desc = "Open NeoTree (floating window)"
vimKeymap("n", "<leader>fe", function() vim.cmd("Neotree float") end, opts);

opts.desc = "Classic save"
vimKeymap("n", "<C-s>", function() vim.cmd("w") end, opts)
opts.desc = "Allow ; to act like : to avoid using shift"
keymap("n", ";", ":", { noremap = true, desc = opts.desc })
opts.desc = "Clear search highlight"
vimKeymap("n", "<ESC>", function() vim.cmd("nohlsearch") end, opts)

----- Buffer manip ----
opts.desc = "Open new buffer"
vimKeymap("n", "<leader>bn", function() vim.cmd("tabnew") end, opts)
opts.desc = "Close current buffer"
vimKeymap("n", "<Leader>bx", function () require("core.utils").custom_bdelete() end, opts)
opts.desc = "Close all other tabs"
vimKeymap("n", "<leader>bX", function() require("bufferline").close_others() end, opts)
opts.desc = "Pick bufferline tabs"
vimKeymap("n", "<leader>bp", function() require("bufferline").pick() end, opts)
opts.desc = "Go to next buffer"
vimKeymap("n", "<Tab>", function() require("bufferline").cycle(1) end, opts)
opts.desc = "Go to previous buffer"
vimKeymap("n", "<S-Tab>", function() require("bufferline").cycle(-1) end, opts)
opts.desc = "Select word (\\v<..>)"
vimKeymap("n", "<leader>rs", "/\\v<><Left>", { desc = opts.desc})

nvimKeymap("n", "<leader>rw",
	[[:let @/='\<'.expand('<cword>').'\>'<CR>:%s/<C-r>///g<Left><Left>]],
{ desc = "Rename word under cursor"})

vimKeymap("n", "<leader>ih", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end,
{ desc = "Toggle inlay hints" })

opts.desc = "Open vertical split"
vimKeymap("n", "<leader>sv", function() vim.cmd("vertical split") end, opts)
opts.desc = "Open horizontal split"
vimKeymap("n", "<leader>sh", function() vim.cmd("horizontal split") end, opts)
opts.desc = "Close split"
vimKeymap("n", "<leader>sx", function() vim.cmd("close") end, opts)
opts.desc = "Make splits equal"
nvimKeymap("n", "<leader>s=", "<C-w>=", opts)

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

opts.desc = "Automatically centers when C-d"
nvimKeymap("n", "<C-d>", "<C-d>zz", opts)
opts.desc = "Automatically centers when C-u"
nvimKeymap("n", "<C-u>", "<C-u>zz", opts)
opts.desc = "Center when searching"
nvimKeymap("n", "n", "nzzzv", opts)
nvimKeymap("n", "N", "Nzzzv", opts)

----- File Navigation -----
opts.desc = "Open Mini Files"
vimKeymap("n", "<leader>e", function()
	require("mini.files").open()
    vim.wo.cursorline = false
    vim.wo.cursorcolumn = false
end, opts)

----------------------- Insert ----------------------
opts.desc = "Fast exit insert"
nvimKeymap("i", "jk", "<ESC>", opts)

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
nvimKeymap("n", "<leader>/", "gcc", { desc = opts.desc } )
opts.desc = "Toggle comment"
nvimKeymap("v", "<leader>/", "gc", { desc = opts.desc } )

opts.desc = "Indentation plus"
nvimKeymap("v", ">", ">gv", opts)
opts.desc = "Indentation minus"
nvimKeymap("v", "<", "<gv", opts)

opts.desc = "Keep last yanked when pasting"
nvimKeymap("v", "p", '"_dP', opts)

---------------Which key groups-----------------------


----------------------- Plugins ----------------------
local M = {}

function M.lspconfig(ev)
	opts = { buffer = ev.buf }
	opts.desc = "LSP floating documentation"
	vimKeymap("n", "K", vim.lsp.buf.hover, opts)
	opts.desc = "LSP goto definition"
	vimKeymap("n", "gd", vim.lsp.buf.definition, opts)
	opts.desc = "LSP goto declaration"
	vimKeymap("n", "gD", vim.lsp.buf.declaration, opts)
	opts.desc = "LSP goto implementation"
	vimKeymap("n", "gi", vim.lsp.buf.implementation, opts)
	opts.desc = "LSP rename word under cursor"
	vimKeymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
	opts.desc = "LSP CodeAction"
	vimKeymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	opts.desc = "LSP diagnostic prev"
	vimKeymap("n", "[d", vim.diagnostic.goto_prev, opts)
	opts.desc = "LSP diagnostic next"
	vimKeymap("n", "]d", vim.diagnostic.goto_next, opts)
end

function M.wkgroups()
	local wk = require("which-key")

	wk.add({
		{"<leader>e", icon = "📁"},
		{"<leader>f", group = "Find" },
		{"<leader>s", group = "Splits", icon = "✂️"},
		{"<leader>b", group = "Buffers", icon = "🪟"},
		{"<leader>r", group = "Search & Replace", icon = "👀"},
		{"<leader>x", group = "Diagnostics", icon = "🛠️"},
		{"<leader>n", group = "SwapNext", icon = "⇄"},
		{"<leader>p", group = "SwapPrev", icon = "⇄"},
	})
end

function M.cmp_native(cmp, luasnip)
	return {
		["<C-e>"]	= cmp.mapping.abort(), -- Close
		["<C-b>"]	= cmp.mapping.scroll_docs(-4), -- Move docs up
		["<C-f>"]	= cmp.mapping.scroll_docs(4), -- Move docs down
		['<CR>']	= cmp.mapping(function(fallback)
			if cmp.visible() then
				if luasnip.expandable() then
					luasnip.expand()
				else
					cmp.confirm({ select = true, })
				end
			else
				fallback()
			end
		end),

		["<Tab>"]	= cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.locally_jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"]	= cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}
end

return M
