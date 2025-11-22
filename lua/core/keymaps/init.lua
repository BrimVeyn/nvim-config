-- Load all keymap modules
require("core.keymaps.buffer")
require("core.keymaps.editor")
require("core.keymaps.files")
require("core.keymaps.git")
require("core.keymaps.splits")
require("core.keymaps.terminal")
require("core.keymaps.testing")

-- Export LSP keymaps for use in plugin configurations
local M = {}
M.lspconfig = require("core.keymaps.lsp").lspconfig
M.wkgroups = require("core.keymaps.which-key").setup

return M
