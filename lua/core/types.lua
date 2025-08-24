-- Type definitions for global variables
---@class vim
---@field g table<string, any> Global variables
---@field opt table<string, any> Options
---@field api table<string, function> API functions
---@field diagnostic table<string, function> Diagnostic functions
---@field lsp table<string, function> LSP functions
---@field loop table<string, function> Loop functions

-- Declare global variables that LuaLS doesn't recognize
vim.g.toggle_theme_icon = vim.g.toggle_theme_icon or "  " 