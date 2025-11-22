return {
	"rmagatti/auto-session",
	lazy = false,
	--enables autocomplete for opts
	--@module "auto-session"
	--@type AutoSession.Config
	opts = {
		suppressed_dirs = { '~/', '/' },
		session_lens = {
			picker = 'snacks',        -- "telescope"|"snacks"|"fzf"|"select"|nil Pickers are detected automatically but you can also set one manually. Falls back to vim.ui.select
			picker_opts = nil,        -- Table passed to Telescope / Snacks / Fzf-Lua to configure the picker. See below for more information
			previewer = "active_buffer", -- 'summary'|'active_buffer'|function - How to display session preview. 'summary' shows a summary of the session, 'active_buffer' shows the contents of the active buffer in the session, or a custom function
		},
	},
}
