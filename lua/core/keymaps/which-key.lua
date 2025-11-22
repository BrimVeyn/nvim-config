-- Which-key group configuration
local M = {}

function M.setup()
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
