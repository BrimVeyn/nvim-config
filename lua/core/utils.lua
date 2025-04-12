local M = {}

function M.darken_color(color, factor)
	-- Split the hex color into RGB components
	local r = tonumber(color:sub(2, 3), 16)
	local g = tonumber(color:sub(4, 5), 16)
	local b = tonumber(color:sub(6, 7), 16)

	-- Apply the darkening factor
	r = math.max(math.floor(r * factor), 0)
	g = math.max(math.floor(g * factor), 0)
	b = math.max(math.floor(b * factor), 0)

	-- Return the darkened color as a hex string
	return string.format("#%02x%02x%02x", r, g, b)
end

function M.hl_name_from_mode(mode)
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

function M.get_mode_hl_color(darkening_factor)
	local mode = vim.api.nvim_get_mode().mode
	local hl_name = M.hl_name_from_mode(mode)
	local hl_obj = vim.api.nvim_get_hl(0, { name = hl_name, link = false } )
	local fg_color = nil;
	-- Back up to white in case nvim_get_hl fails somehow (happens with neotest gui)
	if hl_obj.fb == nil then
		fg_color = "#FFFFFF"
	else
		fg_color = string.format("#%06x", hl_obj.fg)
	end
	return M.darken_color(fg_color, darkening_factor)
end

function M.custom_bdelete()
	local curr_buf = vim.api.nvim_get_current_buf()
	local wins = vim.api.nvim_list_wins()
	local visible_buffers = {}

	for _, win in ipairs(wins) do
		local buf = vim.api.nvim_win_get_buf(win)
		visible_buffers[buf] = true
	end

	local num_visible_buffers = vim.tbl_count(visible_buffers)
	print(vim.inspect(vim.api.nvim_get_current_buf()))

	if num_visible_buffers > 1 then
		require("bufferline").cycle(1)
	end
	vim.cmd("confirm bdelete " .. curr_buf)
end

return M
