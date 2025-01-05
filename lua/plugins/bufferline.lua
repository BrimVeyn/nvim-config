local function hl_name_from_mode(mode)
	local mode_names = {
		['n']  = 'NormalMode',
		['i']  = 'InsertMode',
		['v']  = 'VisualMode',
		['V']  = 'VisualMode',
		['']  = 'VisualMode',
		['R']  = 'ReplaceMode',
		['c']  = 'CommandMode',
		['t']  = 'TerminalMode',
		['nt'] = 'TerminalNormal',
	}
	return mode_names[mode] or 'NormalMode'
end

local function update_mode()
	local mode = vim.api.nvim_get_mode().mode
	local hl_name = hl_name_from_mode(mode)
	local hl_obj = vim.api.nvim_get_hl(0, { name = hl_name, link = false } )
	-- print(vim.inspect({mode, hl_name}))
	vim.api.nvim_set_hl(0, "BufferlineBufferSelected", { fg = hl_obj.fg })
end

local function create_autocmd()
	local augroup = vim.api.nvim_create_augroup("Namicator", {})

	vim.api.nvim_create_autocmd("BufEnter", {
		callback = update_mode,
		group = augroup,
	})

	vim.api.nvim_create_autocmd("ModeChanged", {
		callback = update_mode,
		group = augroup,
	})

end

return {
	'akinsho/bufferline.nvim',
	version = "*",
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function()
		create_autocmd()

		require('bufferline').setup({
			options = {
				themable = true,
				separator_style = "slope",
			},
			highlights = {
				buffer_selected = {
					bold = true,
					italic = false,
				},
			}
		})
	end,
}
