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
	local fg_color = string.format("#%06x", hl_obj.fg)
	return M.darken_color(fg_color, darkening_factor)
end

return M
