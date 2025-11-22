local vimKeymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Inlay hints
vimKeymap("n", "<leader>ih", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		vim.notify("Inlay hints " .. (vim.lsp.inlay_hint.is_enabled() and "enabled" or "disabled"))
	end,
	{ desc = "Toggle inlay hints" })

-- TypeScript tools
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

vimKeymap("n", "<leader>ox",
	function()
		if vim.bo.filetype == "typescriptreact" or vim.bo.filetype == "typescript" then
			vim.fn.system("pnpm oxlint --fix " .. vim.fn.expand("%"));
		end
	end, { desc = "Rename file" })

vimKeymap("n", "<leader>fa",
	function()
		if vim.bo.filetype == "typescriptreact" or vim.bo.filetype == "typescript" then
			vim.cmd("TSToolsFixAll");
			vim.wait(100);
			vim.lsp.buf.code_action({ context = { only = { "source.fixAll.eslint" } }, apply = true });
		end
	end, { desc = "Fix all auto-fixable problems" })

-- LSP on attach keymaps
local M = {}

function M.lspconfig(ev)
	opts = { buffer = ev.buf }
	opts.desc = "LSP goto declaration"
	vimKeymap("n", "gD", vim.lsp.buf.declaration, opts)
	opts.desc = "LSP goto implementation"
	vimKeymap("n", "gi", vim.lsp.buf.implementation, opts)
	opts.desc = "LSP rename word under cursor"
	vimKeymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
end

return M
