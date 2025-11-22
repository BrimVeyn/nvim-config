return {
	"rmagatti/auto-session",
	lazy = false,

	--enables autocomplete for opts
	--@module "auto-session"
	--@type AutoSession.Config
	opts = {
		suppressed_dirs = { '~/', '/' },
		-- log_level = 'debug',
	},
	keys = {
		-- Will use Telescope if installed or a vim.ui.select picker otherwise
		-- { "<leader>fs", "<cmd>SessionSearch<CR>", desc = "Session search" },
		-- { "<leader>ss", "<cmd>SessionSave<CR>",   desc = "Save session" },
	},
}
