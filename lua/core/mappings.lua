local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap = true, silent = true }

----------------------- Normal ----------------------
opts.desc = "Fuzzy find files in project"
vim.keymap.set("n", "<leader>ff", function() vim.cmd("Telescope find_files") end, opts)
opts.desc = "Fuzzy find in project"
vim.keymap.set("n", "<leader>fw", function() vim.cmd("Telescope live_grep") end, opts)
opts.desc = "Fuzzy find in current buffer"
vim.keymap.set("n", "<leader>fz", function() vim.cmd("Telescope current_buffer_fuzzy_find") end, opts)
opts.desc = "Find lsp references"
vim.keymap.set("n", "<leader>fr", function() vim.cmd("Telescope lsp_references") end, opts)
opts.desc = "Fuzzy find TODOs"
vim.keymap.set("n", "<leader>ft", function() vim.cmd("TodoTelescope") end, opts)

opts.desc = "Classic save"
vim.keymap.set("n", "<C-s>", function() vim.cmd("w") end, opts)
opts.desc = "Allow ; to act like : to avoid using shift"
keymap("n", ";", ":", { noremap = true, desc = opts.desc })
opts.desc = "Clear search highlight"
vim.keymap.set("n", "<ESC>", function() vim.cmd("nohlsearch") end, opts)


----- Buffer manip ----
opts.desc = "Open new buffer"
vim.keymap.set("n", "<leader>bn", function() vim.cmd("tabnew") end, opts)
opts.desc = "Close current buffer"
vim.keymap.set("n", "<Leader>bx", function () require("core.utils").custom_bdelete() end, opts)
opts.desc = "Close all other tabs"
vim.keymap.set("n", "<leader>bX", function() require("bufferline").close_others() end, opts)
opts.desc = "Pick bufferline tabs"
vim.keymap.set("n", "<leader>bp", function() require("bufferline").pick() end, opts)
opts.desc = "Go to next buffer"
vim.keymap.set("n", "<Tab>", function() require("bufferline").cycle(1) end, opts)
opts.desc = "Go to previous buffer"
vim.keymap.set("n", "<S-Tab>", function() require("bufferline").cycle(-1) end, opts)
opts.desc = "Bufferline 'flash'"
vim.keymap.set("n", "<leader>rs", "/\\v<><Left>", { desc = "Select whole word search" })

opts.desc = "Open vertical split"
vim.keymap.set("n", "<leader>sv", function() vim.cmd("vertical split") end, opts)
opts.desc = "Open horizontal split"
vim.keymap.set("n", "<leader>sh", function() vim.cmd("horizontal split") end, opts)
opts.desc = "Close split"
vim.keymap.set("n", "<leader>sx", function() vim.cmd("close") end, opts)
opts.desc = "Make splits equal"
keymap("n", "<leader>s=", "<C-w>=", opts)

opts.desc = "Move focus left split"
keymap("n", "<C-h>", "<C-w>h", opts)
opts.desc = "Move focus down split"
keymap("n", "<C-j>", "<C-w>j", opts)
opts.desc = "Move focus up split"
keymap("n", "<C-k>", "<C-w>k", opts)
opts.desc = "Move focus right split"
keymap("n", "<C-l>", "<C-w>l", opts)

opts.desc = "Resize up"
vim.keymap.set("n", "<C-Up>", function() vim.cmd("resize -2") end, opts)
opts.desc = "Resize down"
vim.keymap.set("n", "<C-Down>", function() vim.cmd("resize +2") end, opts)
opts.desc = "Resize left"
vim.keymap.set("n", "<C-Left>", function() vim.cmd("vertical resize -2") end, opts)
opts.desc = "Resize right"
vim.keymap.set("n", "<C-Right>", function() vim.cmd("vertical resize +2") end, opts)

opts.desc = "Automatically centers when C-d"
keymap("n", "<C-d>", "<C-d>zz", opts)
opts.desc = "Automatically centers when C-u"
keymap("n", "<C-u>", "<C-u>zz", opts)
opts.desc = "Center when searching"
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

----- File Navigation -----
opts.desc = "Open Mini Files"
keymap("n", "<leader>e", ":lua MiniFiles.open()<CR>", opts)

----------------------- Insert ----------------------
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

----------------------- Visual ----------------------
opts.desc = "Move selection one line down"
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
opts.desc = "Move selection one line up"
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

opts.desc = "Toggle comment"
keymap("n", "<leader>/", "gcc", { desc = opts.desc } )
opts.desc = "Toggle comment"
keymap("v", "<leader>/", "gc", { desc = opts.desc } )

opts.desc = "Indentation plus"
keymap("v", ">", ">gv", opts)
opts.desc = "Indentation minus"
keymap("v", "<", "<gv", opts)

opts.desc = "Keep last yanked when pasting"
keymap("v", "p", '"_dP', opts)

----------------------- Plugins ----------------------
local M = {}

function M.lspconfig(ev)
	opts = { buffer = ev.buf }
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
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
