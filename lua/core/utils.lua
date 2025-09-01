local bl       = require("bufferline")
local bl_pick  = require("bufferline.pick")
local bl_cmd   = require("bufferline.commands")
local bl_state = require("bufferline.state")

local M        = {}

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
		['nt'] = 'Terminalnormalmode',
	}
	return mode_names[mode] or 'NormalMode'
end

function M.get_mode_hl_color(darkening_factor)
	local mode = vim.api.nvim_get_mode().mode
	local hl_name = M.hl_name_from_mode(mode)
	-- vim.inspect(print(mode))
	local hl_obj = vim.api.nvim_get_hl(0, { name = hl_name, link = false })
	local fg_color = nil;
	-- Back up to white in case nvim_get_hl fails somehow (happens with neotest gui)
	if hl_obj.fg == nil then
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
	-- print(vim.inspect(vim.api.nvim_get_current_buf()))

	if num_visible_buffers > 1 then
		require("bufferline").cycle(1)
	end
	vim.cmd("confirm bdelete " .. curr_buf)
end

function M.bufferLineMoveTo(id)
	local _, current = bl_cmd.get_current_element_index(bl_state)
	if current == nil then return end

	local current_ord, target_ord = nil, nil

	for _, elem in ipairs(bl_state.components) do
		if elem ~= nil and elem.id == id then target_ord = elem.ordinal end
		if elem ~= nil and elem.id == current.id then current_ord = elem.ordinal end
	end
	if not target_ord or not current_ord then return end

	local direction = target_ord > current_ord and 1 or -1

	while current_ord ~= target_ord do
		current_ord = current_ord + direction
		bl.move(direction)
	end
end

function M.bufferLinePickMove()
	bl_pick.choose_then(M.bufferLineMoveTo)
end

function M.bufferLineCloseManyPick()
	while true do
		local status = bl.close_with_pick()
		if status == -1 then break end
	end
end

-- Function to open URL in browser based on OS
local function open_url_in_browser(url)
	local platform = vim.loop.os_uname().sysname

	if platform == "Darwin" then
		-- macOS
		os.execute('open "' .. url .. '"')
	elseif platform == "Linux" then
		-- Linux
		os.execute('xdg-open "' .. url .. '"')
	elseif platform == "Windows_NT" then
		-- Windows
		os.execute('start "" "' .. url .. '"')
	else
		print("Unsupported platform: " .. platform)
		return false
	end

	return true
end

-- Function to open the current file in Cursor at the current line
function M.open_in_cursor()
	local file_path = vim.fn.expand("%:p")
	local line_number = vim.fn.line(".")
	local workspace_dir = "/Users/galadrim/Projects/ansut"

	-- First: Open the folder via URL scheme
	local folder_url = "cursor://file/" .. workspace_dir .. "?windowId=_blank"

	vim.notify("Opening folder: " .. folder_url, vim.log.levels.INFO)

	-- Open the folder first
	if open_url_in_browser(folder_url) then
		-- Wait a bit for Cursor to load, then open the specific file
		vim.defer_fn(function()
			-- Now use CLI to open the specific file at the right line
			local cmd = string.format('cursor --goto "%s:%s"', file_path, line_number)

			vim.notify("Running command: " .. cmd, vim.log.levels.INFO)

			-- Execute the command
			local result = vim.fn.system(cmd)

			if vim.v.shell_error == 0 then
				vim.notify("Opened file in Cursor", vim.log.levels.INFO)
			else
				vim.notify("Failed to open file (cmd: " .. cmd .. ")", vim.log.levels.ERROR)
			end
		end, 1000) -- 1000ms delay to let Cursor open
	else
		vim.notify("Failed to open folder in Cursor", vim.log.levels.ERROR)
	end
end

return M
